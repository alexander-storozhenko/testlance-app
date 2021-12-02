require 'api/defaults'
module API
  module Tests
    class Results < Grape::API
      include Defaults

      format :json

      authenticate!

      params do
        requires :test_id, type: Integer
      end

      get 'results' do
        test = Test.find(params[:test_id])

        TestResultWorker.perform_async(test.id)

        ''
      rescue => error
        error!(error, 400)
      end
    end
  end
end