require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  root to: 'user_registrations#new'
  match 'signup', to: 'user_registrations#new', via: :get

  resources :user_registrations, only: [:new, :create]
  resources :user_verifications, only: [:new, :create]
  get 'signup', to: 'user_registrations#new'
  get 'verify', to: 'user_verifications#new'

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == ENV['SIDEKIQ_USERNAME'] && password == ENV['SIDEKIQ_PASSWORD']
  end if Rails.env.production?

  mount Sidekiq::Web => '/sidekiq'
end
