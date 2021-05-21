require 'api/defaults'

module API
  module Constructor
    module Edit
      class QuestionParams < Grape::API
        include Defaults
        format :json

        authorize! send_error: true

        params do
          requires :question_type, type: String, values: %w[one, some]
          optional :question_time, type: String
        end

        patch 'question_params' do
          test_t = TestTemplate.find_by!(user: @user, status: :editing)
          question_t = QuestionTemplate.update!(
              test_template: test_t,
              question_type: params[:question_type]
          )

          sleep 2
          present question_id: question_t.id
        rescue => error
          error!(error, 400)
        end
      end
    end
  end
end





