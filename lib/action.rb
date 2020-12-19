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

  def check_min(param)
    return true if @require[param].nil?

    stat = param.dup
    stat[0] = ''
    stat[0] = ''
    stat[0] = ''
    stat[0] = ''
    return false if @target.stats[stat] < @require[param]
  end

  def check_max(param)
    return true if @require[param].nil?

    stat = param.dup
    stat[0] = ''
    stat[0] = ''
    stat[0] = ''
    stat[0] = ''
    return false if @target.stats[stat] > @require[param]
  end

  def check_max_req
    return false if check_max('max_health') == false ||
                    check_max('max_mana') == false ||
                    check_max('max_fun') == false ||
                    check_max('max_money') == false ||
                    check_max('max_fatigue') == false ||
                    check_max('max_intellect') == false
  end

  def check_min_req
    return false if check_min('min_health') == false ||
                    check_min('min_mana') == false ||
                    check_min('min_fun') == false ||
                    check_min('min_money') == false ||
                    check_min('min_fatigue') == false ||
                    check_min('min_intellect') == false
  end

  def check_require
    return true if @require.nil? || @target.nil?
    return false if check_min_req == false || check_max_req == false

    true
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
