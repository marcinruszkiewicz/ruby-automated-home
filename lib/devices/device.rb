# frozen_string_literal: true

require 'ruby_home'

class Device
  attr_accessor :device # access to physical or network device

  # setup the device here
  def initialize
    raise NotImplementedError
  end

  # this gets called in a loop every 30 seconds, so return status here
  def call
    raise NotImplementedError
  end
end
