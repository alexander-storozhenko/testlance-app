require 'api/defaults'
module API
  module Debug
    class Debug < Grape::API
      include Defaults
      format :json
      authorize! role: :admin, send_error: true

      get 'debug' do
        @user.email
      end
    end
  end
end



