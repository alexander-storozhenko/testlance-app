require_relative 'index'
require_relative 'set_answer'
module API
  module Recommends
    class Root < Grape::API
        namespace 'recommends' do
            mount Index
            mount SetAnswer
        end
     end
  end
end