require './lib/valera'

RSpec.describe Action do
  describe 'Checking initialization' do
    test = Valera.new('start', './lib/start_config.yml')
    it {
      expect(test.stats['health'].should(eql(100)))
      expect(test.stats['mana'].should(eql(0)))
      expect(test.stats['health'].should(eql(100)))
      expect(test.stats['money'].should(eql(400)))
      expect(test.stats['fatigue'].should(eql(0)))
      expect(test.stats['intellect'].should(eql(0)))
      expect((test.is_death).should(eql(false)))
    }
  end
end
