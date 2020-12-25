require 'yaml'

class ConfigLoader
  attr_reader :actions, :start, :limits

  def initialize(path_action = nil, path_start = nil, path_limits = nil, start = 'start')
    @actions = YAML.load_file(path_action) unless path_action.nil?
    @start = YAML.load_file(path_start) unless path_start.nil?
	@start = @start[start]
    @limits = YAML.load_file(path_limits) unless path_limits.nil?
  end
end
