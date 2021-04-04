require_relative 'index'
require_relative 'set_answer'
require_relative 'post'
module API
  module Recommends
    class Root < Grape::API
        namespace 'recommends' do
            mount Index
            mount SetAnswer
            mount Post
        end
     end
  end
end