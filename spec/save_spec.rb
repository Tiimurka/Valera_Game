require 'rspec'
require 'json'
require './lib/save'
require './lib/load'
require './lib/valera'
require './lib/config_loader'

RSpec.describe Save do
  loader = ConfigLoader.new('./lib/action_config.yml', './lib/start_config.yml', './lib/limits_config.yml')
  describe 'Checking save' do
    valera1 = Valera.new(loader.start, loader.limits, 'test')
    Save.new(valera1).create_save('test/test', 'saves/')
    valera2 = Valera.new(loader.start, loader.limits)
    Load.new('test/test', 'saves/').load_file(valera2)
    it {
      expect((valera1.stats).should(eql(valera2.stats)))
    }
  end
end
