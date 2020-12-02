require_relative 'get'
module API
module Tests
  class Root < Grape::API
    namespace 'tests' do
        mount Get
        mount Results
      end
    end
  end
end