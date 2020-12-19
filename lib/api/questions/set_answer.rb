require 'api/defaults'
module API
  module Questions
    class SetAnswer < Grape::API
      include Defaults

      auth

      params do
        requires :question_id, type: Integer
        requires :test_id, type: Integer
        requires :answers, type: Hash
      end

      get 'set_answers' do
        present Question.find(params[:question_id])
                    .set_answer(user_id: session[:current_user].id,
                                test_id: params[:question_id],
                                answers: params[:answers]
                    )
      end
    end
  end
end