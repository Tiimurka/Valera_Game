require 'io/console'
require_relative 'load'
require_relative 'valera'
require_relative 'menu'
require_relative 'start_menu'
require_relative 'config_loader'

class Game
  def initialize
    loader = ConfigLoader.new('lib/action_config.yml', 'lib/start_config.yml', 'lib/limits_config.yml')
    @valera = Valera.new(loader.start, loader.limits)
    choice_handler(0)
    system('reset')
    @menu = Menu.new(loader.actions, @valera)
    step while @valera.is_death == false
    @valera.print_death_message
  end

  def step
    @menu.print_stats
    @menu.print_options
    message_action_selection
    choice = gets.chomp.to_i
    @menu.choice_handler(choice)
  end

  def message_action_selection
    print "\n|‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
    print "\n| Выберите действие: "
  end

  def choice_handler(choice)
    case choice
    when 1
      nil
    when 2
      name_load = Load.enter_filename
      Load.new(name_load).load_file(@valera)
    when 3
      exit
    else
      system('reset')
      print_start_menu
      message_action_selection
      choice = gets.chomp.to_i
      choice_handler(choice)
    end
  end
end
