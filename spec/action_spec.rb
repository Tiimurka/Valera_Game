require './lib/action'
require './lib/valera'

RSpec.describe Action do
  describe 'Checking initialization' do
    test = Action.new(0, nil, './lib/action_config.yml')
    it {
      expect((test.name).should(eq('work')))
      expect(test.stats['info'].should(eq('Пойти на работу')))
      expect(test.stats['message'].should(eq('msg_work')))
      expect(test.stats['help'].should(eq('help_work')))
      expect(test.stats['fun'].should(eql(-5)))
      expect(test.stats['mana'].should(eql(30)))
      expect(test.stats['money'].should(eql(100)))
      expect(test.stats['fatigue'].should(eql(70)))
    }
  end

  describe 'Checking print_info' do
    test = Action.new(1, nil, './lib/action_config.yml')
    it { expect { test.print_info }.to output("2: Созерцать природу\n").to_stdout }
  end

  describe 'Checking execute' do
    valera = Valera.new('start', './lib/start_config.yml')
    test = Action.new(3, valera, './lib/action_config.yml')
    test.execute
    it {
      expect(valera.stats['health'].should(eql(60)))
    }
  end
end
