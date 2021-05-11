require 'api/defaults'
module API
  module Tests
    class Delete < Grape::API
      include Defaults
      format :json

      authorize! send_error: true

      params do
        requires :id, desc: 'User test template id'
      end

      delete 'delete/:id' do
        test_t = TestTemplate.find_by(id: params[:id], author: @user)

        raise 'Test not found!' unless test_t

        test_t.destroy!
        #test_t.test_recommends.where(test_template: test_t).destroy_all!
        {status: 'ok'}
      rescue => error
        error!(error, 400)
      end
    end
  end
end