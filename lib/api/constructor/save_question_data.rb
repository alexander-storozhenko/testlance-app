require 'api/defaults'
module API
  module Constructor
    class SaveQuestionData < Grape::API
      include Defaults
      format :json
      authorize! send_error: true

      params do
        requires :question_id, type: String
        requires :title_type, type: String
        requires :title, type: String
        requires :sub_title, type: String
        requires :answers_type, type: String
        requires :answers, type: String
        requires :true_answers, type: String
      end

      post 'save_question_data' do
        content_type 'multipart/form-data'

        question_t = QuestionTemplate.find(params[:question_id])

        raise 'Question not exists!' unless question_t

        question_t.update!(
            data: {
                title_type: params[:title_type],
                title: params[:title],
                sub_title: params[:sub_title],
                answers_type: params[:answers_type],
                answers: params[:answers],
                true_answers: params[:true_answers]
            }
        )

        sleep 3
        {}
      rescue => error
        error!(error, 400)
      end
    end
  end
end






