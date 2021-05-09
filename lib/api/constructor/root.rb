require_relative 'save_card'
require_relative 'save_question_params'
require_relative 'save_question_data'
require_relative 'main_info'

module API
  module Constructor
    class Root < Grape::API
      namespace 'constructor' do
        mount SaveCard
        mount SaveQuestionParams
        mount SaveQuestionData
        mount MainInfo
      end
    end
  end
end


