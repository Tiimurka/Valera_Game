require './lib/valera'
require './lib/action'

RSpec.describe Valera do
  describe 'Checking initialization' do
    test = Valera.new('start', './lib/start_config.yml', './lib/limits_config.yml')
    it do
      expect(test.stats['health'].should(eql(100)))
      expect(test.stats['mana'].should(eql(0)))
      expect(test.stats['health'].should(eql(100)))
      expect(test.stats['money'].should(eql(400)))
      expect(test.stats['fatigue'].should(eql(0)))
      expect(test.stats['intellect'].should(eql(0)))
      expect((test.is_death).should(eql(false)))
    end
  end

  describe 'Checking limits & death' do
    valera1 = Valera.new('start', './lib/start_config.yml', './lib/limits_config.yml')
    valera2 = Valera.new('start', './lib/start_config.yml', './lib/limits_config.yml')
    act_c = Action.new(1, valera1, './lib/action_config.yml')
    act_c.execute
    act_m = Action.new(3, valera2, './lib/action_config.yml')
    act_r = Action.new(7, valera2, './lib/action_config.yml')
    act_m.execute
    act_r.execute
    it do
      expect(valera1.stats['mana'].should(eql(0)))
      expect((valera2.is_death).should(eql(true)))
      expect((valera2.msg).should(eql('Валера заснул и не проснулся...')))
    end
  end
end
