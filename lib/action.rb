require_relative 'valera'

class Action
  attr_accessor :stats
  attr_reader :name

  def initialize(num, target = nil, path_to_config = 'action_config.yml')
    @stats = YAML.load_file(path_to_config)
    @name = @stats.keys[num]
    @stats = @stats[@stats.keys[num]]
    @num = num
    @target = target
    @require = @stats['require']
  end

  def print_info
    info = @stats['info']
    info = @name if info.nil?
    puts "#{@num + 1}: #{info}" + (check_require ? '' : ' (невозможно)')
  end

  def check_require_node(param, node)
    return false if !node['max'].nil? && @target.stats[param] > node['max']
    return false if !node['min'].nil? && @target.stats[param] < node['min']

    true
  end

  def check_require
    return true if @require.nil? || @target.nil?

    i = 0
    res = true
    while i < @require.count
      param = @require.keys[i]
      node = @require[param]
      res = check_require_node(param, node)
      i += 1
    end
    res
  end

  def changer(param)
    @target.stats[param] += @stats[param] unless @stats[param].nil?
  end

  def execute
    return unless check_require

    changer('health')
    changer('mana')
    changer('fun')
    changer('money')
    changer('fatigue')
    changer('intellect')
    @target&.check_limits
  end
end
