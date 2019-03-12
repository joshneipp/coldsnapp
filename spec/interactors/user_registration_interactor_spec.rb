require 'rails_helper'

describe UserRegistrationInteractor do

  subject { UserRegistrationInteractor.run(params) }
  let(:valid_params) do
    {
      user: {
        username: 'myusername',
        password: 'valid_password',
        sms_number: '1231231234',
        settings: {
          "zip_code": "12345"
        }
      }
    }
  end
  
  context 'with missing password' do
    let(:params) { valid_params.deep_merge( { user: { password: ''} } ) }
    it 'returns an invalid password error' do
      expect(subject.errors.full_messages).to include('Password is required')
    end
  end
  
  context 'with missing username' do
    let(:params) { valid_params.deep_merge( { user: { username: ''} } ) }
    it 'returns an invalid username error' do
      expect(subject.errors.full_messages).to include('Username is required')
    end
  end

  context 'with invalid phone number' do
    let(:params) { valid_params.deep_merge( { user: { sms_number: '1231234' } } ) }
    it 'returns an invalid phone number error' do
      expect(subject.errors.full_messages).to include('Phone number must be in the format 1231231234 or (123)123-1234 or 1 (123) 123-1234')
    end
  end

  context 'with invalid zip code' do

    context 'too short' do
      let(:params) { valid_params.deep_merge( { user: { settings: { "zip_code": "123" } } } ) }
      it 'returns an invalid zip code error' do
        expect(subject.errors.full_messages).to include('Zip code must be 5 digits')
      end
    end

    context 'too long' do
      let(:params) { valid_params.deep_merge( { user: { settings: { "zip_code": "123456789" } } } ) }
      it 'returns an invalid zip code error' do
        expect(subject.errors.full_messages).to include('Zip code must be 5 digits')
      end
    end

    context 'not numeric' do
      let(:params) { valid_params.deep_merge( { user: { settings: { "zip_code": "123ab" } } } ) }
      it 'returns an invalid zip code error' do
        expect(subject.errors.full_messages).to include('Zip code must be 5 digits')
      end
    end
  end

  context 'valid params' do
    let(:params) { valid_params }
    it 'runs the user registration service' do
      allow_any_instance_of(UserRegistrationService).to receive(:run)
      expect_any_instance_of(UserRegistrationService).to receive(:run)
      subject
    end
  end
end