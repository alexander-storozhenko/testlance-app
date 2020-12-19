require 'api/defaults'
module API
  module Tests
    class Get < Grape::API
      include Defaults

      auth

      get 'test/:id' do
        template = TestTemplate.find(params[:id])
        test = template.generate_user_test!(session[:current_user].id)

        first_question = QuestionTemplate.find(test.question_templates.first)
            .generate_user_question!(user_id: session[:current_user].id, test_id: test.id)

        present test, first_question
      end
    end
  end
end