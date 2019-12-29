require_relative 'config'
require_relative 'devices/device'
require_relative 'devices/sensor'
require_relative 'devices/switch'
require 'ruby_home'

class Home
  attr_reader :config

  def initialize
    @config = Config.new

    @devices = []
    @devices << Switch.new(
      ip: @config.config.dig('home', 'switch', 'ip'),
      user: @config.config.dig('home', 'switch', 'user'),
      password: @config.config.dig('home', 'switch', 'password'),
      device_name: @config.config.dig('home', 'switch', 'name')
    )
    @devices << Sensor.new(
      address: @config.config.dig('home', 'sensor', 'address'),
      device_name: @config.config.dig('home', 'sensor', 'name')
    )
  end

  def start
    start_loop
    RubyHome.run
  end

  private

  def start_loop
    Thread.new do
      loop do
        @devices.each do |device|
          device.call
        end

        sleep 5
      end
    end
  end
end
