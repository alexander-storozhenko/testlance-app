require_relative 'get'
require_relative 'set_answers'
module API
  module Questions
    class Root < Grape::API
        namespace 'questions' do
            mount Get
            mount SetAnswers
        end
     end
  end
end