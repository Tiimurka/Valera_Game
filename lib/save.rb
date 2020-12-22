require 'json'

class Save
  def initialize(target)
    @stats = target.stats
  end

  def create_save(path, folder = './saves/')
    File.open("#{folder}#{path}.json", 'w') do |f|
      f.write(@stats.to_json)
    end
  end

  def self.enter_filename
    print 'Введите название сохранения: '
    name = gets.chomp.to_s
    system('reset')
	return name
  end
end
