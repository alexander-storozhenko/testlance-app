require 'api/defaults'
module API
  module Questions
    class Get < Grape::API
      include Defaults

      auth

      get ':id' do
        present QuestionTemplate.find(params[:id])
                    .generate_user_question!(user_id: session[:current_user].id, test_id: test.id)
      end
    end
  end
end