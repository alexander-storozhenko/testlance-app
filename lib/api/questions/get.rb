require 'api/defaults'
module API
  module Questions
    class Get < Grape::API
      include Defaults
      format :json

      #authorize!

      params do
        requires :test_id, type: Integer
        requires :question_number, type: Integer
      end

      get 'get' do
        test = Test.find(params[:test_id])
        question = test.questions.find_by(number: params[:question_number])

        test.update!(user_data: {start_time: DateTime.now}) if params[:question_number].zero?
        question_t = question.template
        #TODO Entity
        present question: question, data: question_t, title_image_url: question_t.title_image_url
      end
    end
  end
end