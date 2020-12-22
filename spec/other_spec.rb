require './lib/start_menu'
require './lib/dictionary'

RSpec.describe Action do
  describe 'Checking print_start_menu' do
    it {
      expect { print_start_menu }.to output("|‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾|\n| 1. Новая игра	    |\n| 2. Загрузить игру |\n|"\
   " 3. Выход	    |\n|___________________|\n").to_stdout
    }
  end
  
  describe 'Checking dictionary' do
    it {
	  expect(DICTIONARY['intellect'].should(eql('Интеллект')))
	}
  end
end
