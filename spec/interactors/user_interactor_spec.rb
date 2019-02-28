require 'rails_helper'

describe UserInteractor do

  subject { UserInteractor.run!(params) }
  let(:params) do
    {
      username: 'valid_user_name',
      password: 'valid_password',
      settings: settings
    } 
  end

  context 'invalid zip code that is too short' do
    
    let(:settings) { {"zip_code": "123"} }

    it 'raises an InvalidZipCodeError' do
      expect{subject}.to raise_error(UserInteractor::InvalidZipCodeError)
    end
  end

  context 'invalid zip code that is too long' do

    let(:settings) { {"zip_code": "1234567"} }

    it 'raises an InvalidZipCodeError' do
      expect{subject}.to raise_error(UserInteractor::InvalidZipCodeError)
    end
  end

  context 'invalid zip code that is not numeric' do

    let(:settings) { {"zip_code": "123ab"} }

    it 'raises an InvalidZipCodeError' do
      expect{subject}.to raise_error(UserInteractor::InvalidZipCodeError)
    end
  end

  context 'invalid zip code that is not a string' do

    let(:settings) { {"zip_code": 12345} }

    it 'raises an InvalidInteractionError' do
      expect{subject}.to raise_error(ActiveInteraction::InvalidInteractionError)
    end
  end
end