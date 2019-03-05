require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  get 'home_pages/index'
  root to: 'home_pages#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => '/sidekiq'
end
