# frozen_string_literal: true

require 'i2c_drivers'
require 'i2c_drivers/device/bme280'

device = I2CDrivers::Bme280.new(address: 0x77)

p device.read_id
p device

device.write_config(I2CDrivers::Bme280::T_STANDBY_0_5MS, I2CDrivers::Bme280::FILTER_16)
device.write_ctrl_hum(I2CDrivers::Bme280::OVERSAMPLE_1)
device.write_ctrl_meas(I2CDrivers::Bme280::OVERSAMPLE_16, I2CDrivers::Bme280::OVERSAMPLE_2, I2CDrivers::Bme280::MODE_NORMAL)
p device.calc_sensor_data