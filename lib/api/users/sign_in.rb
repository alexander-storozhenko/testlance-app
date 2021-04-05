require 'bcrypt'
module API
  module Users
    class SignIn < Grape::API
      include Defaults

      format :json

      params do
        requires :login
        requires :password
      end

      patch 'sign_in' do
        user = User.find_by(name: params[:login])

        user.authenticate!(params[:password])

        session[:current_user] = user

        user.generate_token

        present token: user.oauth_token

       rescue StandardError => e
         error! e.message
      end
    end
  end
end