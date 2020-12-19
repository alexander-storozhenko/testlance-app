require_relative 'get'
require_relative 'results'
require_relative 'recommends'
require_relative 'pack'
module API
module Tests
  class Root < Grape::API
    namespace 'tests' do
        mount Get
        mount Results
        mount Recommends
        mount Pack
      end
    end
  end
end