require 'rails_helper'

describe CreateUserService do

  subject { CreateUserService.new(settings).run }
  let(:settings) { {"settings": {"zip_code": "12345"}} }

  it 'saves a new user' do
    expect { subject }.to change { User.count }.by(+1)
  end

  context 'user settings request notification' do
    
  end
end