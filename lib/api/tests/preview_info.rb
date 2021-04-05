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
        Test.where(user_id: @user.id).each do |t|
          t.destroy_questions
          t.destroy
        end

        test = Test.new(user_id: @user.id, test_template_id: params[:test_t_id])

        question_count = QuestionTemplate.where(test_template_id: params[:test_t_id]).count
        questions_t = QuestionTemplate.where(test_template_id: params[:test_t_id])
        questions = questions_t.map{|q| q.from_template(@user.id, test.id)}

        test.questions = questions
        test.save!

        data = JSON.parse(test.template.to_json).merge({question_count: question_count})

        present test_id: test.id, data: data
      end
    end
  end
end

