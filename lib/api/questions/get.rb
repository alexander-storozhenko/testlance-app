require 'api/defaults'
module API
  module Questions
    class Get < Grape::API
      include Defaults
      format :json

      # auth

      params do
        requires :test_id, type: Integer
        requires :question_number, type: Integer
      end

      get 'get' do
        test = Test.find(params[:test_id])
        question = test.questions[params[:question_number]]

        test.update!(user_data: {start_time: DateTime.now}) if params[:question_number].zero?

        question_t = QuestionTemplate.find(question.question_template_id)

        p question,question_t
        present question: question, data: question_t

      end
    end
  end
end