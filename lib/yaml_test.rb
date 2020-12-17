require 'yaml'

yaml_test = YAML.load_file('action_config.yml')
/puts yaml_test['fun']/
puts yaml_test.count
i = 0
while i < yaml_test.count do
    puts yaml_test[yaml_test.keys[i]]
	i+=1
end