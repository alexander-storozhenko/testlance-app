require 'api/defaults'
module API
  module Questions
    class SetAnswers < Grape::API
      include Defaults

      format :json

      # auth

      params do
         requires :question_id, type: Integer
         requires :answers, type: String
      end

      patch 'set_answers' do
         question = Question.find(params[:question_id])

         bad_request!('Not allowed', 403) if question.blank? #|| question.user_id != @user.id

         question.set_answers(JSON.parse(params[:answers]))

         sleep 2
        present ''
      rescue => error
        error!(error, 400)
      end
    end
  end
end