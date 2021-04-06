require 'bcrypt'
module API
  module Users
    class SignIn < Grape::API
      include Defaults

      format :json

      params do
        requires :name
        requires :password
      end

      put 'sign_in' do
        user = User.find_by(name: params[:name])

        raise 'Incorrect login or password' unless  user

        user.authenticate!(params[:password])

        session[:current_user] = user

        user.generate_token

        present access_token: user.oauth_token

       rescue StandardError => e
         error! e.message
      end
    end
  end
end