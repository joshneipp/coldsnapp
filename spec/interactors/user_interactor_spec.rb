require 'rails_helper'

describe UserInteractor do

  subject { UserInteractor.run!(params) }
  context 'invalid zip code that is not five digits' do
    let(:params) { {"settings": settings} }
    let(:settings) { {"zip_code": "123"} }
    it 'raises an error' do
      expect{subject}.to raise_error(UserInteractor::InvalidZipCodeError)
    end
  end

end