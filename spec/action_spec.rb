require './lib/action'
require './lib/valera'
require './lib/config_loader'

RSpec.describe Action do
  describe 'Checking initialization' do
    loader = ConfigLoader.new('./lib/action_config.yml', './lib/start_config.yml', './lib/limits_config.yml')
    test = Action.new(0, loader.actions)

    it {
      expect(test.name).to eq('work')
    }

    it {
      expect(test.stats['info']).to eq('Пойти на работу')
    }

    it {
      expect(test.params['fun']).to eq(-5)
    }

    it {
      expect(test.params['mana']).to eq(-30)
    }

    it {
      expect(test.params['money']).to eq(100)
    }

    it {
      expect(test.params['fatigue']).to eq(70)
    }
  end

  describe 'Checking printers' do
    loader = ConfigLoader.new('./lib/action_config.yml', './lib/start_config.yml', './lib/limits_config.yml')
    valera = Valera.new(loader.start, loader.limits)
    test1 = Action.new(0, loader.actions)
    test2 = Action.new(0, loader.actions, valera)
    test2.execute
    test2.stats['message'] = nil
    test3 = Action.new(0, loader.actions)
    it {
      expect { test1.print_info }.to output("1: Пойти на работу\n").to_stdout
    }
    it {
      expect { test1.print_message }.to output("Предыдущее действие: Пойти на работу\n\n").to_stdout
    }
    it {
      expect { test2.print_info }.to output("1: Пойти на работу (невозможно)\n").to_stdout
    }
    it {
      expect { test2.print_message }.to output("Предыдущее действие: Пойти на работу\n\n").to_stdout
    }
    it {
      expect { test3.print_help }.to output("1: Пойти на работу\n\tЖизнерадостность -5  Мана -30  "\
         "Деньги +100  Усталость +70  \n"\
         "\t\tДля выполнения необходимо:  Мана меньше чем 50, Усталость меньше чем 10,\n\n").to_stdout
    }
  end

  describe 'Checking execute' do
    loader1 = ConfigLoader.new('./lib/action_config.yml', './lib/start_config.yml', './lib/limits_config.yml')
    loader2 = ConfigLoader.new('./lib/action_config.yml', './lib/start_config.yml', './lib/limits_config.yml')
    valera1 = Valera.new(loader1.start, loader1.limits)
    valera2 = Valera.new(loader2.start, loader2.limits)
    test1 = Action.new(3, loader1.actions, valera1)
    test2 = Action.new(0, loader2.actions, valera2)
    puts valera2.stats
    test1.execute
    puts valera2.stats
    test2.execute
    puts valera2.stats
    test2.execute
    puts valera2.stats
    it {
      expect(valera1.stats['health']).to eq(60)
    }
    puts valera2.stats
    it {
      expect(valera2.stats['fatigue']).to eq(70)
    }
  end

  describe 'Checking require' do
    loader = ConfigLoader.new('./lib/action_config.yml', './lib/start_config.yml', './lib/limits_config.yml')
    loader1 = ConfigLoader.new('./lib/action_config.yml', './lib/start_config.yml', './lib/limits_config.yml')
    valera = Valera.new(loader.start, loader.limits)
    valera1 = Valera.new(loader1.start, loader1.limits)
    test1 = Action.new(3, loader.actions, valera)
    test1.execute
    test2 = Action.new(0, loader.actions, valera)
    test3 = Action.new(1, loader.actions, valera)
    test4 = Action.new(3, loader1.actions, valera1)
    valera1.stats['money'] = 0

    it {
      expect(test2.check_require).to eq(false)
    }

    it {
      expect(test3.check_require).to eq(true)
    }

    it {
      expect(test4.check_require).to eq(false)
    }
  end
end
