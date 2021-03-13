require 'api/defaults'
module API
  module Questions
    class SetAnswers < Grape::API
      include Defaults

      format :json

      # auth

      params do
        # requires :question_id, type: Integer
        # requires :answers, type: JSON
      end

      post 'set_answers' do
        # question = Question.find(params[:question_id])
        #
        # bad_request!('Not allowed', 403) if question.blank? || question.users_id != @user.id

        # question.set_answers(params[:answers])

        # sleep 2
        present ''
      end
    end
  end
end