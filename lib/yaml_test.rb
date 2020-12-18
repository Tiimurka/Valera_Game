require 'yaml'
require_relative 'valera'

yaml_test = YAML.load_file('action_config.yml')
/puts yaml_test['fun']/
puts yaml_test.count
i = 0
while i < yaml_test.count do
    puts yaml_test[yaml_test.keys[i]]
	i+=1
end

v = Valera.new
puts
i = 0
while i < yaml_test.count do
    puts v.stats[v.stats.keys[i]]
	i+=1
end

puts v.is_death
