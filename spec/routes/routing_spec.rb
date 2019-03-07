require 'rails_helper'

describe '/register', :type => :routing do
  it 'should route to user_registrations#new' do
    expect(:get => '/register')
      .to route_to(:controller => 'user_registrations', :action => 'new')
  end
end