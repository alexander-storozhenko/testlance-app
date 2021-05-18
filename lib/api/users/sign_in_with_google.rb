require 'api/defaults'

module API
  module Users
    class SignInWithGoogle < Grape::API
      include Defaults

      format :json

      STUB_PASSWORD = "google_pass_MCEnhRLhNqMmhOGq1Blu".freeze

      params do
        requires :name, type: String
        requires :email, type: String
        requires :image_url, type: String
        requires :google_access_token, type: String
      end

      patch 'sign_in_with_google' do
        user = User.find_by(google_access_token: params[:google_access_token])

        p 1
        p params
        if user
          user.update!(
              name: params[:name],
              email: params[:email],
              image_url: params[:image_url],
              google_access_token: params[:google_access_token]
          )
        else
          p 2
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
        p 3
        p 4

        present access_token: user.jwt
      rescue => e
        error!(e, 400)
      end
    end
  end
end