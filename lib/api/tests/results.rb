require 'api/defaults'
module API
  module Tests
    class Results < Grape::API
      include Defaults

      format :json

      # auth

      params do
        requires :test_id, type: Integer
      end

      get 'results' do
        time = DateTime.now.to_time
        test = Test.find(params[:test_id])
        user = User.find(1)
        diff = time - DateTime.parse(test.user_data['start_time']).to_time

        data = {
            lasted_time: '%d:%02d:%02d' % [ diff / 3600, (diff / 60) % 60, diff % 60 ],
        }

        raise 'result already exists' if Result.exists?(users: user, tests: test)

        result = Result.create!(users: user, tests: test, data: data)

        present result

      rescue => error
        error!(error,400)
      end
    end
  end
end


