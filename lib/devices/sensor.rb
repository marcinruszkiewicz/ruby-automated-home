# frozen_string_literal: true

require 'rah_bme280'
require 'ruby_home'

# physical bme280 environmental sensor
# attached to the raspberry pi this script is running on
class Sensor < Device
  def initialize(address:, device_name:)
    # prepare access to physical device on a gpio pin
    @device = RahBme280::Device.new(address: address)

    # prepare service factories
    @temperature = RubyHome::ServiceFactory.create(
      :temperature_sensor,
      current_temperature: 0.0,
      name: "#{device_name} Temperature"
    )
    @humidity = RubyHome::ServiceFactory.create(
      :humidity_sensor,
      current_relative_humidity: 0.0,
      name: "#{device_name} Humidity"
    )
  end

  def call
    # get data from physical sensor
    data = @device.calc_sensor_data

    # update homekit data from physical values
    @temperature.current_temperature = data[:temp]
    @humidity.current_relative_humidity = data[:hum]
  end
end
