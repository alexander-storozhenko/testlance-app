require 'api/defaults'
module API
  module Tests
    class PreviewInfo < Grape::API
      include Defaults

      format :json

      # auth

      params do
        requires :test_t_id, type: Integer
      end

      get 'preview_info' do
        @user = User.find(1)
        Test.where(users_id: @user.id).each do |t|
          t.destroy_questions
          t.destroy
        end
        p '1'
        test = Test.new(users_id: @user.id, test_templates_id: params[:test_t_id])

        question_count = QuestionTemplate.where(test_templates_id: params[:test_t_id]).count

        questions_t = QuestionTemplate.where(test_templates_id: params[:test_t_id])

        questions = questions_t.map{|q| q.from_template(@user.id, test.id)}
        p '2'
        test.questions = questions
        p test
        test.save!

        data = JSON.parse(test.template.to_json).merge({question_count: question_count})

        present test_id: test.id, data: data
      end
    end
  end
end

