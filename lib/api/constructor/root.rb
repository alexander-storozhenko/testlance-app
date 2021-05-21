require_relative 'new/card'
require_relative 'new/question_params'
require_relative 'edit/card'
require_relative 'edit/question_data'
require_relative 'edit/question_params'

require_relative 'main_info'

module API
  module Constructor
    class Root < Grape::API
      namespace 'constructor' do
        mount New::Card
        mount New::QuestionParams

        mount Edit::Card
        mount Edit::QuestionData
        mount Edit::QuestionParams

        mount MainInfo
      end
    end
  end
end


