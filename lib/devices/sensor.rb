# frozen_string_literal: true

require 'rah_bme280'
require 'ruby_home'

# physical bme280 environmental sensor
# attached to the raspberry pi this script is running on
class Sensor < Device
  def initialize(address:, device_name:)
    # prepare access to physical device on a gpio pin
    @device = RahBme280::Device.new(address: address)

    data = @device.status
    # prepare service factories
    @temperature = RubyHome::ServiceFactory.create(
      :temperature_sensor,
      current_temperature: data[:temperature],
      name: "#{device_name} Temperature"
    )
    @humidity = RubyHome::ServiceFactory.create(
      :humidity_sensor,
      current_relative_humidity: data[:humidity],
      name: "#{device_name} Humidity"
    )
  end

  def call
    # get data from physical sensor
    data = @device.status

    # update homekit data from physical values
    @temperature.current_temperature = data[:temperature]
    @humidity.current_relative_humidity = data[:humidity]
  end
end
