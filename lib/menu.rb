require 'io/console'
require_relative 'dictionary'
require_relative 'action'
require_relative 'save'

class Menu
  def initialize(target = nil, path_to_config = 'action_config.yml')
    @config = YAML.load_file(path_to_config)
    @help_num = @config.count
    @save_num = @config.count + 1
    @exit_num = @config.count + 2
    @target = target
  end

  def print_stats
    i = 0
    while i < @target.stats.count
      param = @target.stats.keys[i]
      puts "#{DICTIONARY[param] || param}: #{@target.stats[param]}"
      i += 1
    end
  end

  def print_options
    i = 0
    while i < @config.count
      Action.new(i, @target).print_info
      i += 1
    end
    print "#{@help_num + 1}: Помощь\n"
    print "#{@save_num + 1}: Сохранить игру\n"
    print "#{@exit_num + 1}: Выход\n"
  end

  def print_help
    i = 0
    while i < @config.count
      Action.new(i, @target).print_help
      i += 1
    end
  end

  def choice_handler_actions(choice)
    Action.new(choice, @target).execute
    system('reset')
    Action.new(choice).print_message if Action.new(choice, @target).check_require == true
  end

  def choice_handler(cho)
    choice = cho - 1
    if choice < @config.count
      choice_handler_actions(choice)
    elsif choice == @help_num
      system('reset')
      print_help
      print 'Press any key'
      $stdin.getch
      system('reset')
    elsif choice == @save_num
      save = Save.new(@target)
      file_name = Save.enter_filename
      save.create_save(file_name)
    elsif choice == @exit_num
      exit
    end
  end
end
