require 'yaml'

class Config
  attr_reader :config

  def initialize
    config_file = File.join('config', 'home.yml')
    @config = YAML.load_file config_file
  end
end
