require 'api/defaults'

module API
  module Users
    class SignInWithGoogle < Grape::API
      include Defaults

      authorize! send_error: true

      params do
        requires :name
        requires :image_url
        requires :google_access_token
      end

      patch 'sign_in_with_google' do
        user = User.find_by(google_access_token: params[:google_access_token])

        if user
          user.update!(
              name: params[:name],
              image_url: params[:image_url],
              google_access_token: params[:google_access_token]
          )
        else
          User.create!(
              login_type: :google,
              name: params[:name],
              image_url: params[:image_url],
              google_access_token: params[:google_access_token]
          )
        end

      rescue => e
        error!(e, 400)
      end
    end
  end
end