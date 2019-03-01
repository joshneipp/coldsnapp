FactoryBot.factories.map(&:name).each do |factory_name|
  describe "Factory #{factory_name}" do
    it 'is valid' do
      # TODO get this to work with DatabaseCleaner settings
      # expect(build(factory_name)).to be_valid
    end
  end
end