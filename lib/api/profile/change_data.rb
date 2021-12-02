require 'api/defaults'
module API
  module Profile
    class ChangeData < Grape::API
      include Defaults
      format :json

      LIMIT = 20

      authenticate! send_error: true

      params do
        optional :nickname, type: String
      end

      patch 'change_data' do
        ProfileChange.add_nickname_request(@user.id, params[:nickname])

        present {}
      rescue => error
        error!(error, 400)
      end
    end
  end
end

