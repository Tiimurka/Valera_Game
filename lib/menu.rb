require 'io/console'
require_relative 'dictionary'
require_relative 'action'
require_relative 'save'

class Menu
  def initialize(config, target = nil)
    @config = config
    @help_num = @config.count
    @save_num = @config.count + 1
    @exit_num = @config.count + 2
    @target = target
  end

  def print_stats
    puts '|‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾'
	@target.stats.each do |key, value|
      puts "| #{DICTIONARY[key] || key}: #{value}"
    end
    puts "|________________________\n\n"
  end

  def print_options
    (0..@config.count - 1).each do |i|
      Action.new(i, @config, @target).print_info
    end
    print "#{@help_num + 1}: Помощь\n"
    print "#{@save_num + 1}: Сохранить игру\n"
    print "#{@exit_num + 1}: Выход\n"
  end

  def print_help_actions
    (0..@config.count - 1).each do |i|
      Action.new(i, @config, @target).print_help
    end
  end

  def choice_handler_actions(choice)
    act = Action.new(choice, @config, @target)
    check = act.check_require
    act.execute
    system('reset')
    act.print_message if check == true
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
    if choice >= 0 && choice < @config.count
      choice_handler_actions(choice)
    elsif choice == @help_num
      help
    elsif choice == @save_num
      save = Save.new(@target)
      file_name = Save.enter_filename
      save.create_save(file_name)
    elsif choice == @exit_num
      exit
    else
      system('reset')
    end
  end
end
