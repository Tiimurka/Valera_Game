require 'json'

class Save
  def initialize(target)
    @stats = target.stats
  end

  def create_save(path, folder = './../saves/')
    File.open("#{folder}#{path}.json", 'w') do |f|
      f.write(@stats.to_json)
    end
  end

  def self.enter_filename
    gets.chomp.to_s
  end
end
