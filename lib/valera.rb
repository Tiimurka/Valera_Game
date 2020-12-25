require 'yaml'

class Valera
  attr_accessor :stats, :is_death, :limits, :msg

  def initialize(stats, limits, start = 'start')
    @stats = stats
    @limits = limits
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
    limit_correction('max', param, node) if !node['max'].nil? && @stats[param] >= node['max']['amount']
    limit_correction('min', param, node) if !node['min'].nil? && @stats[param] <= node['min']['amount']
  end

  def check_limits
    @limits.each do |key, value|
      param = key
      check_limit_node(param, value)
      break if @is_death == true
    end
  end

  def print_death_message
    puts @msg
  end
end
