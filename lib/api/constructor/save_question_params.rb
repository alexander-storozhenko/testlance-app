require 'api/defaults'
module API
  module Constructor
    class SaveQuestionParams < Grape::API
      include Defaults
      format :json
      authorize! send_error: true

      params do
        requires :question_type, type: String
        optional :question_time, type: String
      end

      post 'save_question_params' do
        test_t = TestTemplate.find_by!(user: @user, status: :constructing)
        question_t = QuestionTemplate.create!(test_template: test_t, question_type: params[:question_type])

        sleep 3
        {question_id: question_t.id}
      rescue => error
        error!(error, 400)
      end
    end
  end
end





