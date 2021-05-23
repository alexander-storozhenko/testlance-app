require 'api/defaults'

module API
  module Constructor
    module New
      class QuestionParams < Grape::API
        include Defaults
        format :json

        authorize! send_error: true

        params do
          requires :question_type, type: String, values: %w[one some]
          optional :question_time, type: String
        end

        post 'question_params' do
          test_t = TestTemplate.find_by!(user: @user, status: :constructing)
          question_t = QuestionTemplate.create!(test_template: test_t, question_type: params[:question_type])

          sleep 3
          present question_id: question_t.id
        rescue => error
          error!(error, 400)
        end
      end
    end
  end
end





