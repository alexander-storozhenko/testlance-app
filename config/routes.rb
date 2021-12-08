require 'api/api'

Rails.application.routes.draw do
  resources :tests

  # devise_for :admin_panel_users, controllers: { registrations: 'validator' }
  devise_for :admin_panel_users

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'



  mount ActionCable.server => '/cable'

  mount API::API => '/'

  namespace :admin do
    root to: "users#index"
  end

  devise_scope :admin_panel_user do
    get '/validator', to: "validator#index"
  end
end
