require 'bcrypt'
require 'auth'
module API
  module Users
    class SignIn < Grape::API
      include Defaults
      include Auth

      format :json

      params do
        requires :name
        requires :password
      end

      put 'sign_in' do
        user = User.where(name: params[:name]).or(User.where(email: params[:name])).first

        raise 'Incorrect login or password' unless user

        user.authenticate!(params[:password])
        session[:current_user] = user

        present access_token: encode_jwt({id: user.id})
       rescue StandardError => e
         error! e.message
      end
    end
  end
end