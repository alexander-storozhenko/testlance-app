require 'api/defaults'
module API
  module Constructor
    class MainInfo < Grape::API
      include Defaults
      format :json
      authenticate! send_error: true

      params do
        requires :id, desc: 'User test template id'
      end

      get 'main_info/:id' do
        test_t = TestTemplate.find_by(id: params[:id], author: @user)

        raise 'Test not found!' unless test_t

        sleep 2
        present test_t, with: Entities::Constructor::MainInfo
      rescue => error
        error!(error, 400)
      end
    end
  end
end




