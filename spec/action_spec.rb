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
      expect(test.params['fun'].should(eql(-5)))
      expect(test.params['mana'].should(eql(30)))
      expect(test.params['money'].should(eql(100)))
      expect(test.params['fatigue'].should(eql(70)))
    }
  end

  describe 'Checking printers' do
    valera = Valera.new('start', './lib/start_config.yml', './lib/limits_config.yml')
    test1 = Action.new(0, nil, './lib/action_config.yml')
    test2 = Action.new(0, valera, './lib/action_config.yml')
    test2.execute
    test2.stats['message'] = nil
    it {
      expect { test1.print_info }.to output("1: Пойти на работу\n").to_stdout
      expect { test1.print_message }.to output("msg_work\n").to_stdout
      expect { test2.print_info }.to output("1: Пойти на работу (невозможно)\n").to_stdout
      expect { test2.print_message }.to output("work_msg\n").to_stdout
    }
  end

  describe 'Checking execute' do
    valera1 = Valera.new('start', './lib/start_config.yml', './lib/limits_config.yml')
    valera2 = Valera.new('start', './lib/start_config.yml', './lib/limits_config.yml')
    test1 = Action.new(3, valera1, './lib/action_config.yml')
    test2 = Action.new(0, valera2, './lib/action_config.yml')
    test1.execute
    test2.execute
    test2.execute
    it {
      expect(valera1.stats['health'].should(eql(60)))
      expect(valera2.stats['fatigue'].should(eql(70)))
    }
  end

  describe 'Checking require' do
    valera = Valera.new('start', './lib/start_config.yml', './lib/limits_config.yml')
    valera1 = Valera.new('start', './lib/start_config.yml', './lib/limits_config.yml')
    test1 = Action.new(3, valera, './lib/action_config.yml')
    test1.execute
    test2 = Action.new(0, valera, './lib/action_config.yml')
    test3 = Action.new(1, valera, './lib/action_config.yml')
    test4 = Action.new(3, valera1, './lib/action_config.yml')
    valera1.stats['money'] = 0
    it {
      expect((test2.check_require).should(eql(false)))
      expect((test3.check_require).should(eql(true)))
      expect((test4.check_require).should(eql(false)))
    }
  end
end
