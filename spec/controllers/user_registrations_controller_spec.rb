require 'rails_helper'

describe UserRegistrationsController do

  describe '.create' do

    subject { post :create, params: params }
    let(:valid_user_params) do
      {
        user: {
          username: Faker::Internet.username,
          password: Faker::Internet.password,
          sms_number: ENV.fetch('TWILIO_TEST_SMS_TO'),
          settings: {
            zip_code: '12345'
          }
        }
      }
    end

    context 'with invalid params' do

      context 'with missing password' do
        let(:params) { valid_user_params.deep_merge( { user: { password: '' } } ) }
        it 'is redirects back to signup page' do
          expect(subject).to redirect_to('/signup')
        end

        it 'is returns an invalid password error' do
          subject
          expect(flash[:notice]).to eq('Password is required')
        end
      end
  
      context 'with missing username' do
        let(:params) { valid_user_params.deep_merge( { user: { username: '' } } ) }
        it 'is redirects back to signup page' do
          expect(subject).to redirect_to('/signup')
        end

        it 'is returns an invalid username error' do
          subject
          expect(flash[:notice]).to eq('Username is required')
        end
      end

      context 'with invalid phone number' do
        let(:params) { valid_user_params.deep_merge( { user: { sms_number: 'wrong' } } ) }
        it 'is redirects back to signup page' do
          expect(subject).to redirect_to('/signup')
        end

        it 'is returns an invalid phone number error' do
          subject
          expect(flash[:notice]).to eq('Phone number must be in the format 1231231234 or (123)123-1234 or 1 (123) 123-1234')
        end
      end

      context 'with invalid zip code' do
        let(:params) { valid_user_params.deep_merge( { user: { settings: { zip_code: 'wrong' } } } ) }

        it 'is redirects back to signup page' do
          expect(subject).to redirect_to('/signup')
        end

        it 'returns an invalid zip code message' do
          subject
          expect(flash[:notice]).to eq('Zip code must be 5 digits')
        end
      end
    end

    context 'with valid params' do
      let(:params) { valid_user_params }
      it 'is successful' do
        stub_twilio_request
        subject
        expect(response.status).to eq(302)
      end

      it 'creates a new user' do
        stub_twilio_request
        expect { subject }.to change { User.count }.by(+1)
      end

      it 'sends an sms message to the new user' do
        stub_twilio_request
        expect_any_instance_of(TwilioService).to receive(:send_message)
        subject
      end

      it 'sets a valid session' do
        stub_twilio_request
        subject
        expect(session[:user_id]).to eq(User.last.id)
      end

      it 'redirects to the user verification path' do
        stub_twilio_request
        expect(subject).to redirect_to('/verify')
      end
    end
  end
end

# TODO extract this into a helper
def stub_twilio_request
  allow_any_instance_of(TwilioService).to receive(:send_message)
end
