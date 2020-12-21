require 'json'

class Load
  def initialize(file_name, folder = './saves/')
    @file = File.read("#{folder}#{file_name}.json")
  end

  def load_file(valeron)
    @stats = JSON.parse @file
    valeron.stats = @stats
  end

  def self.enter_filename
    files = []
    Dir['./saves/**/*.json'].each_with_index do |item, index|
      files[index] = item
      puts "#{index + 1}) #{item.sub!('.json', '').sub!('./saves/', '')}"
    end
    filename = gets.chomp.to_s
    unless files.include?(filename.to_s)
      puts 'error-1: file does not exist'
      exit
    end
    filename
  end
end
