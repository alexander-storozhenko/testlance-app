require 'api/api'

Rails.application.routes.draw do
  resources :tests
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount ActionCable.server => '/cable'
  mount API::API => '/api'

  namespace :admin do
    root to: "users#index"
  end
end
