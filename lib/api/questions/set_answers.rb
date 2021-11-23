require 'api/defaults'
module API
  module Questions
    class SetAnswers < Grape::API
      include Defaults

      format :json

      #authorize!

      params do
        requires :question_number, type: Integer
        requires :question_type, type: String, values: %w[one some 1to1] # TODO hmmm????
        requires :answers, type: String
        requires :test_id, type: String
      end

      patch 'set_answers' do
        question = Question.find_by(test_id: params[:test_id], number: params[:question_number])

        #bad_request!('Not allowed', 403) if question.blank? #|| question.user_id != @user.id
        question.set_answers!(JSON.parse(params[:answers]))
        present {}
      rescue => error
        error!(error, 400)
      end
    end
  end
end