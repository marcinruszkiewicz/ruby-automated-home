# frozen_string_literal: true

require 'rah_tasmota_basic'
require 'ruby_home'

# sonoff basic switch with Tasmota firmware on it
class Switch < Device
  def initialize(ip:, user:, password:, device_name:)
    @device = RahTasmotaBasic::Device.new(ip: ip, user: user, password: password)

    # prepare service factories
    @switch = RubyHome::ServiceFactory.create(
      :switch,
      on: @device.status,
      name: device_name
    )

    @switch.on.after_update do |on|
      if on
        @device.on
      else
        @device.off
      end
    end
  end

  def call

  end
end
