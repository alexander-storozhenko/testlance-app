require_relative 'add_recommend'
module API
  module Debug
    class Root < Grape::API
      namespace 'debug' do
        mount AddRecommend
      end
    end
  end
end

