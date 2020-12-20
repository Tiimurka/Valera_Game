require_relative 'valera'
require_relative 'dictionary'

class Action
  attr_accessor :stats, :params
  attr_reader :name

  def initialize(num, target = nil, path_to_config = 'action_config.yml')
    @stats = YAML.load_file(path_to_config)
    @name = @stats.keys[num]
    @stats = @stats[@stats.keys[num]]
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
    msg = @stats['message']
    msg = "#{@name}_msg" if msg.nil?
    puts msg
  end

  def print_help1
    print_info
    help = @stats['help']
    help = "#{@name}_help" if help.nil?
    puts help
    i = 0
    while i < @params.count
      param = @params.keys[i]
      print "#{DICTIONARY[param] || param} " + ((@params[param]).positive? ? '+' : '') + "#{@params[param]}, "
      i += 1
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
    print 'Для выполнения необходимо:'
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
    return if @require.nil?

    print_help2
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
    @target.stats[param] += @params[param] unless @params[param].nil?
  end

  def execute
    return unless check_require

    i = 0
    while i < @params.count
      changer(@params.keys[i])
      i += 1
    end
    @target&.check_limits
  end
end
