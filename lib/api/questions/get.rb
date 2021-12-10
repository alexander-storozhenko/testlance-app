require 'api/defaults'
module API
  module Questions
    class Get < Grape::API
      include Defaults
      format :json

      authenticate!

      params do
        requires :test_id, type: Integer
        requires :question_number, type: Integer
      end

      get 'get' do
        test = Test.find(params[:test_id])
        question = test.questions.find_by(number: params[:question_number])
        test.update!(user_data: {start_time: DateTime.now}) if params[:question_number].zero?

        present question, with: Entities::Questions::Question
      end
    end
  end
end