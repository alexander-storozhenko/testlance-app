require 'api/defaults'
module API
  module Tests
    class Results < Grape::API
      include Defaults

      auth

      params do
        requires :test_id
      end

      get 'results' do
        questions_id = Test.find(test_id).questions
        questions = Question.where(id: questions_id)

        present questions.map {|question| question.answers_result}
      end
    end
  end
end