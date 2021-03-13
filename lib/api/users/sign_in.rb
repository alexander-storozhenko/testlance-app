require 'bcrypt'
module API
  module Users
    class SignIn < Grape::API
      include Defaults

      format :json
      format :json
      params do
        requires :login
        requires :password
      end

      post 'sign_in' do
        user = User.find_by(name: params[:login], password: params[:password])
        session[:current_user] = user

        error! 'incorrect login or password' unless user

        user.generate_token!

        present token: user.authentication_token
      # rescue StandardError => e
      #   error! e.message
      end
    end
  end
end