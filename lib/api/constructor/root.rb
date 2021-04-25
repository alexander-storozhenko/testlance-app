require_relative 'save_card'
require_relative 'save_question_params'

module API
  module Constructor
    class Root < Grape::API
      namespace 'constructor' do
        mount SaveCard
        mount SaveQuestionParams
      end
    end
  end
end


