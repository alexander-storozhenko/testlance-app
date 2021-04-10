require_relative 'add_recommend'
require_relative 'debug'
module API
  module Debug
    class Root < Grape::API
      namespace 'debug' do
        mount AddRecommend
        mount Debug
      end
    end
  end
end

