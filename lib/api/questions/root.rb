require_relative 'get'
require_relative 'set_answer'
module API
  module Questions
    class Root < Grape::API
        namespace 'questions' do
            mount Get
            mount SetAnswer
        end
     end
  end
end