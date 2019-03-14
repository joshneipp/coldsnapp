require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  root to: 'user_registrations#new'
  match 'signup', to: 'user_registrations#new', via: :get
  # get 'signup', to: 'user_registrations#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => '/sidekiq'

  # resources :user_registrations, only: [:new, :create, :show]

  resources :user_registrations, only: [:new, :create]
  resources :user_verifications, only: [:new, :create]
  get 'signup', to: 'user_registrations#new'
  get 'verify', to: 'user_verifications#new'
end
