# frozen_string_literal: true

require 'i2c_drivers'
require 'i2c_drivers/device/bme280'

device = I2CDrivers::Device::Bme280.new(address: 0x77)
p device.calc_sensor_data