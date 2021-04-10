require_relative 'index'
require_relative 'set_answer'
require_relative 'post'
require_relative 'save_in_profile'
module API
  module Recommends
    class Root < Grape::API
        namespace 'recommends' do
            mount Index
            mount SetAnswer
            mount Post
            mount SaveInProfile
        end
     end
  end
end