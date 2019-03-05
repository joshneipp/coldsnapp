require 'rails_helper'

FactoryBot.factories.map(&:name).each do |factory_name|
  describe "Factory #{factory_name}" do
    it 'is valid' do
      expect(build(factory_name)).to be_valid
    end
  end
end