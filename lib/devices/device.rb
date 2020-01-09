# frozen_string_literal: true

require 'ruby_home'

class Device
  attr_accessor :device # access to physical or network device

  # setup the device here
  def initialize
    raise NotImplementedError
  end

  # do nothing if device doesn't have any status updates
  def call; end
end
