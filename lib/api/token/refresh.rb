require 'api/defaults'
module API
  module Token
    class Refresh < Grape::API
      include Defaults

      format :json

      params do
        requires :rt
      end

      get 'refresh' do
        access_token = AccessToken.find_by(refresh_token: params[:rt])

        raise 'Access token not found' unless access_token

        present access_token.new_jwt
      end
    end
  end
end


