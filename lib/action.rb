require_relative 'valera'

class Action
  attr_accessor :stats
  def initialize (num, path_to_config = 'action_config.yml')
    @stats = YAML.load_file('action_config.yml')
	@name = @stats.keys[num]
	@stats = @stats[@stats.keys[num]]
	@num = num
	
  end
  
  def print_info
    info = @stats['info']
	if (info == nil)
	  info = @name
	end
    puts "#{@num+1}: #{info}" 
  end
  
end