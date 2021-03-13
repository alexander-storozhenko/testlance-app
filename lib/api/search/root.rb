require_relative 'get'
module API
  module Search
    class Root < Grape::API
        namespace 'search' do
            mount Get
        end
     end
  end
end
