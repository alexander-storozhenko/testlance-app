require 'api/defaults'
module API
  module Constructor
    class Delete < Grape::API
      include Defaults
      format :json
      authorize! send_error: true

      params do
        requires :id, desc: 'User test template id'
      end

      delete 'delete' do

      rescue => error
        error!(error, 400)
      end
    end
  end
end





