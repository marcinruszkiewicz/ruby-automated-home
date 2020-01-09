require_relative 'devices/device'
require_relative 'devices/sensor'
require_relative 'devices/switch'
require 'ruby_home'
require 'yaml'

class Home
  attr_reader :config

  def initialize
    config_file = File.join('config', 'home.yml')
    @config = YAML.load_file config_file

    @devices = []
    @devices << Switch.new(
      ip: @config.dig('home', 'switch', 'ip'),
      user: @config.dig('home', 'switch', 'user'),
      password: @config.dig('home', 'switch', 'password'),
      device_name: @config.dig('home', 'switch', 'name')
    )
    @devices << Sensor.new(
      address: @config.dig('home', 'sensor', 'address'),
      device_name: @config.dig('home', 'sensor', 'name')
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

        # this loop is mostly used for temperature updates
        # so updating them once a minute is enough
        sleep 60
      end
    end
  end
end
