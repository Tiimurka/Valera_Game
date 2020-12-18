require 'yaml'

class Valera
  attr_accessor :stats, :is_death

  def initialize(level = 'start', path_to_config = 'start_config.yml')
    @stats = YAML.safe_load(File.read(path_to_config))[level]
    @is_death = false
  end
end
