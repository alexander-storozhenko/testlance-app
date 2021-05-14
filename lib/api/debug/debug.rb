require 'api/defaults'
module API
  module Debug
    class Debug < Grape::API
      include Defaults
      format :json
      authorize! role: :admin

      get 'debug' do
        NotificationJob.perform_later('TESTS')
      end
    end
  end
end



