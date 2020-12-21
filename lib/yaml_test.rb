require 'yaml'
require 'json'
require_relative 'valera'
require_relative 'action'
require_relative 'save'
require_relative 'load'

yaml_test = YAML.load_file('action_config.yml')
puts yaml_test.count
i = 0
while i < yaml_test.count
  puts yaml_test[yaml_test.keys[i]]
  i += 1
end

print "\nВывод списка действий\n"
i = 0
configure = YAML.load_file('action_config.yml')
while i < configure.count
  Action.new(i).print_info
  i += 1
end
print "Вывод списка действий закончен\n\n"

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

act_w = Action.new(0, v)
puts act_w.name
act_w.print_info

i = 0
while i < yaml_test.count
  printer = Action.new(i)
  printer.print_info
  i += 1
end

print "\nВывод характеристик\n"
i = 0
while i < v.stats.count
  param = v.stats.keys[i]
  puts "#{DICTIONARY[param] || param}: #{v.stats[param]}"
  i += 1
end
print "Вывод характеристик закончен\n\n"

act_m = Action.new(3, v)
puts v.stats
act_m.print_info
act_m.execute
puts v.stats
act_w.print_info
act_r = Action.new(7, v)
act_r.execute
v.print_death_message if v.is_death == true
act_r.print_message
act_r.stats['message'] = nil
act_r.print_message
act_r.print_help
act_w.print_help
Action.new(4).print_help

# valeron = Valera.new
# valeron.stats['money'] = 7
# S = Save.new(valeron)
# name_file = Save.enter_filename
# S.create_save(name_file)

# File.open("test.json", 'w') do |f|
#   f.write(valeron.stats.to_json)
# end

print "Тест загрузки\n"
valeron2 = Valera.new
name_load = Load.enter_filename
Load.new(name_load).load_file(valeron2)
# valeron2.stats = JSON.parse(File.read("test.json"))
puts valeron2.stats
