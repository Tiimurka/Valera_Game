require 'rspec'
require 'json'
require_relative './../lib/save'
require_relative './../lib/load'
require_relative './../lib/valera'

RSpec.describe Save do
  describe 'Checking save' do
    valera1 = Valera.new('test', './lib/start_config.yml', './lib/limits_config.yml')
    Save.new(valera1).create_save('test/test', 'saves/')
    valera2 = Valera.new('start', './lib/start_config.yml', './lib/limits_config.yml')
    Load.new('test/test', 'saves/').load_file(valera2)
    it {
      expect((valera1.stats).should(eql(valera2.stats)))
    }
  end
end
