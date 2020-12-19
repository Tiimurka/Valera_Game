require 'yaml'

class Valera
  attr_accessor :stats, :is_death, :limits, :msg

  def initialize(level = 'start', path_to_config = 'start_config.yml', path_to_limits = 'limits_config.yml')
    @stats = YAML.load_file(path_to_config)[level]
    @limits = YAML.load_file(path_to_limits)
    @is_death = false
    @msg = nil
  end

  def limit_correction(type, param, node)
    unless node[type]['death'].nil?
      @is_death = true
      @msg = node[type]['death']
    end
    @stats[param] = node[type]['amount']
  end

  def check_limit_node(param, node)
    limit_correction('max', param, node) if !node['max'].nil? && @stats[param] > node['max']['amount']
    limit_correction('min', param, node) if !node['min'].nil? && @stats[param] < node['min']['amount']
  end

  def check_limits
    i = 0
    while i < @limits.count
      param = @limits.keys[i]
      node = @limits[param]
      check_limit_node(param, node)
      return if @is_death == true

      i += 1
    end
  end

  def print_death_message
    puts @msg
  end
end
