require_relative 'save_card'
require_relative 'save_question_params'
require_relative 'save_question_data'
require_relative 'main_info'
require_relative 'delete'

module API
  module Constructor
    class Root < Grape::API
      namespace 'constructor' do
        mount SaveCard
        mount SaveQuestionParams
        mount SaveQuestionData
        mount MainInfo
        mount Delete
      end
    end
  end
end


