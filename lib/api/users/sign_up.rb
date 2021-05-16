module API
  module Users
    class SignUp < Grape::API
      include Defaults

      format :json

      params do
        requires :name, type: String
        requires :password, type: String
      end

      post 'sign_up' do
        raise 'User exists' if User.exists?(name: params[:name])

        user = User.create!(name: params[:name], password: params[:password])

        present access_token: user.jwt
       rescue StandardError => e
         error! e.message
      end
    end
  end
end