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
        user = User.find_by(name: params[:name])

        raise 'User exists' if user

        User.create!(name: params[:name], password: params[:password])

        present user
       rescue StandardError => e
         error! e.message
      end
    end
  end
end