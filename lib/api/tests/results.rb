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
        question_count = test.questions.count

        #diff = time - DateTime.parse(test.user_data['start_time']).to_time

        test.questions.each{|q| p "q #{q.id}"}

        result = test.calc_result

        # raise 'result already exists' if Result.exists?(users: user, tests: test)

        data = {
            results: result,
            question_count: question_count,
            #lasted_time: '%d:%02d:%02d' % [ diff / 3600, (diff / 60) % 60, diff % 60 ],
        }

        present Result.create!(test: test, data: data)
      rescue => error
        error!(error, 400)
      end
    end
  end
end


