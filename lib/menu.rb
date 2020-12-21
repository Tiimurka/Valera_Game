require 'io/console'
require_relative 'dictionary'
require_relative 'action'
require_relative 'save'

class Menu
  def initialize(target = nil, path_to_config = 'lib/action_config.yml')
    @config = YAML.load_file(path_to_config)
    @help_num = @config.count
    @save_num = @config.count + 1
    @exit_num = @config.count + 2
    @target = target
  end

  def print_stats
    puts '|‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾'
    i = 0
    while i < @target.stats.count
      param = @target.stats.keys[i]
      puts "| #{DICTIONARY[param] || param}: #{@target.stats[param]}"
      i += 1
    end
    puts "|________________________\n\n"
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

  def print_help_actions
    i = 0
    while i < @config.count
      Action.new(i, @target).print_help
      i += 1
    end
  end

  def choice_handler_actions(choice)
    check = Action.new(choice, @target).check_require
    Action.new(choice, @target).execute
    system('reset')
    Action.new(choice).print_message if check == true
  end

  def help
    system('reset')
    print_help_actions
    print_save_exit
    print "\t\tНажмите любую клавишу для выхода в меню"
    $stdin.getch
    system('reset')
  end

  def print_save_exit
    puts "#{@save_num + 1}: Сохранить игру\n\t"\
      "Вводится название сохранения, затем по этому названию можно загрузиться в начальном меню\n\n"\
      "#{@exit_num + 1}: Выход\n\tЗавершение игры (БЕЗ СОХРАНЕНИЯ!)"
  end

  def choice_handler(cho)
    choice = cho - 1
    if choice < @config.count
      choice_handler_actions(choice)
    elsif choice == @help_num
      help
    elsif choice == @save_num
      save = Save.new(@target)
      file_name = Save.enter_filename
      save.create_save(file_name)
    elsif choice == @exit_num
      exit

    end
  end
end
