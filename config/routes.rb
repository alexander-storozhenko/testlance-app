require 'api/api'
Rails.application.routes.draw do
  # devise_for :users
  resources :tests
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount ActionCable.server => '/cable'
  mount API::API => '/api'
  # delete 'users/sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user
  # devise_for :sessions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
