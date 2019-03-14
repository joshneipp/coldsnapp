require 'rails_helper'

describe '/signup', :type => :routing do
  it 'should route to user_registrations#new' do
    expect(:get => '/signup')
      .to route_to(:controller => 'user_registrations', :action => 'new')
  end
end

describe '/verify', :type => :routing do
  it 'should route to user_registrations#new' do
    expect(:get => '/verify')
      .to route_to(:controller => 'user_verifications', :action => 'new')
  end
end