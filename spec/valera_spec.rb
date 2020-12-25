require './lib/valera'
require './lib/action'
require './lib/config_loader'

RSpec.describe Valera do
  describe 'Checking initialization' do
    loader = ConfigLoader.new('./lib/action_config.yml', './lib/start_config.yml', './lib/limits_config.yml')
    valera = Valera.new(loader.start, loader.limits)

    it {
      expect(valera.stats['health']).to eq(100)
    }

    it {
      expect(valera.stats['mana']).to eq(0)
    }

    it {
      expect(valera.stats['fun']).to eq(30)
    }

    it {
      expect(valera.stats['money']).to eq(400)
    }

    it {
      expect(valera.stats['fatigue']).to eq(0)
    }

    it {
      expect(valera.stats['intellect']).to eq(0)
    }

    it {
      expect(valera.is_death).to eq(false)
    }
  end

  describe 'Checking limits & death' do
    loader = ConfigLoader.new('./lib/action_config.yml', './lib/start_config.yml', './lib/limits_config.yml')
    valera1 = Valera.new(loader.start, loader.limits)
    valera2 = Valera.new(loader.start, loader.limits)
    act_c = Action.new(1, loader.actions, valera1)
    act_c.execute
    act_m = Action.new(3, loader.actions, valera2)
    act_r = Action.new(7, loader.actions, valera2)
    act_m.execute
    act_r.execute

    it {
      expect(valera1.stats['mana']).to eq(0)
    }

    it {
      expect(valera2.is_death).to eq(true)
    }

    it {
      expect(valera2.msg).to eq('Валера заснул и не проснулся...')
    }
  end
end
