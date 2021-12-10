require 'api/defaults'
require 'auth'

module API
  module Users
    class SignInWithGoogle < Grape::API
      include Defaults
      include Auth

      format :json

      STUB_PASSWORD = "google_pass_MCEnhRLhNqMmhOGq1Blu".freeze

      params do
        requires :name, type: String
        requires :email, type: String
        requires :image_url, type: String
        requires :google_access_token, type: String
      end

      patch 'sign_in_with_google' do
        user = User.find_by(email: params[:email])

        if user
          user.update!(
              name: params[:name],
              email: params[:email],
              image_url: params[:image_url],
              google_access_token: params[:google_access_token]
          )
        else
          user = User.create!(
              login_type: :google,
              role: :sub_admin,
              name: params[:name],
              password: STUB_PASSWORD,
              email: params[:email],
              image_url: params[:image_url],
              google_access_token: params[:google_access_token]
          )
        end

        present access_token: encode_jwt({id: user.id})
      rescue => e
        error!(e, 400)
      end
    end
  end
end