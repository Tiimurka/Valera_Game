require_relative 'valera'
require_relative 'dictionary'

class Action
  attr_accessor :stats, :params
  attr_reader :name

  def initialize(num, config, target = nil)
    @name = config.keys[num]
    @stats = config[@name]
    @num = num
    @target = target
    @require = @stats['require']
    @params = @stats['parameters']
  end

  def print_info
    info = @stats['info']
    info = @name if info.nil?
    puts "#{@num + 1}: #{info}" + (check_require ? '' : ' (невозможно)')
  end

  def print_message
    info = @stats['info']
    msg = "Предыдущее действие: #{@stats['info']}" unless info.nil?
    msg = "Предыдущее действие: #{@name}" if msg.nil?
    puts "#{msg}\n\n"
  end

  def print_help1
    # puts ''
    print_info
    # help = @stats['help']
    # help = "#{@name}_help" if help.nil?
    # puts help
    print "\t"
    @params.each do |key, value|
      print "#{DICTIONARY[key] || key} " + (value.positive? ? '+' : '') + "#{value}  "
    end
    puts
  end

  def print_help2_piece(param, node)
    print ' '
    print DICTIONARY[param] || param
    print " меньше чем #{node['max']}," unless node['max'].nil?
    print " больше чем #{node['min']}," unless node['min'].nil?
  end

  def print_help2
    print "\t\tДля выполнения необходимо: "
    i = 0
    while i < @require.count
      param = @require.keys[i]
      node = @require[param]
      print_help2_piece(param, node)
      i += 1
    end
    puts
  end

  def print_help
    print_help1
    if @require.nil?
      puts
      return
    end
    print_help2
    puts
  end

  def check_require_node(param, node)
    return false if !node['max'].nil? && @target.stats[param] > node['max']
    return false if !node['min'].nil? && @target.stats[param] < node['min']

    true
  end

  def check_require
    return true if @require.nil? || @target.nil?

    res = true
    @require.each do |key, value|
      res = check_require_node(key, value)
    end
    res
  end

  def changer(param)
    @target.stats[param] += @params[param] unless @params[param].nil?
  end

  def execute
    return unless check_require

    @params.each do |key, _value|
      changer(key)
    end
    @target&.check_limits
  end
end
