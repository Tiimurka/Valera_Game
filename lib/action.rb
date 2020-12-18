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
  end

  def print_info
    info = @stats['info']
    info = @name if info.nil?
    puts "#{@num + 1}: #{info}"
  end

  def changer(param)
    @target.stats[param] += @stats[param] unless @stats[param].nil?
  end

  def execute
    changer('health')
    changer('mana')
    changer('fun')
    changer('money')
    changer('fatigue')
    changer('intellect')
  end
end
