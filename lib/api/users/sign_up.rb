module API
  module Users
    class SignUp < Grape::API
      include Defaults

      format :json

      params do
        requires :email
        requires :password
      end

      post 'sign_up' do
        user = User.find_by(email: params[:email])
        User.create!(email: params[:email], password: params[:password]) unless user

        present user
      rescue StandardError => e
        error! e.message
      end
    end
  end
end