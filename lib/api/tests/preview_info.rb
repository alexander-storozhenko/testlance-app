require 'api/defaults'
module API
  module Tests
    class PreviewInfo < Grape::API
      include Defaults

      format :json

      authenticate!

      params do
        requires :test_t_id, type: Integer
      end

      get 'preview_info' do
        Test.where(user_id: @user.id).each{|t| t.destroy}

        test_t = TestTemplate.find(params[:test_t_id])
        test = Test.new(user: @user, test_template: test_t)

        questions_t = QuestionTemplate.where(test_template: test_t)
        questions = questions_t.each_with_index.map{|q, index| q.from_template(@user.id, test.id, index + 1)}

        test.questions = questions
        test.save!

        data = {
            options: test_t.options,
            title: test_t.title
        }

        present test_id: test.id, data: data
      end
    end
  end
end

