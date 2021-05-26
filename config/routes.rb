require 'api/api'

Rails.application.routes.draw do
  resources :tests

  devise_for :admin_panel_users

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount ActionCable.server => '/cable'

  mount API::API => '/'

  namespace :admin do
    root to: "users#index"
  end
end
