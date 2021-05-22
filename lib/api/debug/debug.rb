require 'api/defaults'
module API
  module Debug
    class Debug < Grape::API
      include Defaults
      include ActionController::Live

      format :json

      get 'debug' do
        'ok'
      end
    end
  end
end



