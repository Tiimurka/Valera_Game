require 'io/console'
# require_relative 'dictionary'
# require_relative 'action'
require_relative 'load'
require_relative 'valera'
require_relative 'menu'

class Game
  def initialize
    @valera = Valera.new
    choice_handler(0)
    system('reset')
    menu = Menu.new(@valera)
    while @valera.is_death == false
      menu.print_stats
      menu.print_options
      choice = gets.chomp.to_i
      menu.choice_handler(choice)
    end
    @valera.print_death_message
  end

  def print_start_menu
    print "1: Новая игра\n"
    print "2: Загрузить игру\n"
    print "3: Выход\n"
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
      choice = gets.chomp.to_i
      choice_handler(choice)
    end
  end
end
