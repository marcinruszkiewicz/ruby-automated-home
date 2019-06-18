# frozen_string_literal: true

require 'pry'
require 'ruby_home'
require 'i2c_drivers'
require 'i2c_drivers/device/bme280'

sensor = I2CDrivers::Device::Bme280.new(address: 0x77)
# accessory_information = RubyHome::ServiceFactory.create(:accessory_information)
temperature_sensor = RubyHome::ServiceFactory.create(
  :temperature_sensor,
  current_temperature: 0.0
)
humidity_sensor = RubyHome::ServiceFactory.create(
  :humidity_sensor,
  current_relative_humidity: 0.0
)

Thread.new do
  sleep 10

  loop do
    data = sensor.calc_sensor_data

    temperature_sensor.current_temperature = data[:temp]
    humidity_sensor.current_relative_humidity = data[:hum]

    sleep 30
  end
end

# binding.pry
RubyHome.run
