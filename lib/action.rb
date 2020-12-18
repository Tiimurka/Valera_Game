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
  
  def execute
    if @stats['health'] != nil
      @target.stats['health'] += @stats['health']
    end
	if @stats['mana'] != nil
      @target.stats['mana'] += @stats['mana']
    end
    if @stats['fun'] != nil
      @target.stats['fun'] += @stats['fun']
    end
	if @stats['money'] != nil
      @target.stats['money'] += @stats['money']
    end
	if @stats['fatigue'] != nil
      @target.stats['fatigue'] += @stats['fatigue']
    end
	if @stats['intellect'] != nil
      @target.stats['intellect'] += @stats['intellect']
    end
  end
  
end
