require 'yaml'
require_relative 'valera'
require_relative 'action'

yaml_test = YAML.load_file('action_config.yml')
puts yaml_test.count
i = 0
while i < yaml_test.count
  puts yaml_test[yaml_test.keys[i]]
  i += 1
end

v = Valera.new
puts
i = 0
while i < yaml_test.count
  puts v.stats[v.stats.keys[i]]
  i += 1
end

puts v.is_death

test = yaml_test['chill']['name']
if test.nil?
  puts 'lolkek'
else
  puts test
end

act_w = Action.new(0)
puts act_w.name
act_w.print_info
