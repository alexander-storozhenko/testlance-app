require_relative 'user_tests'
module API
  module Profile
    class Root < Grape::API
        namespace 'profile' do
            mount UserTests
        end
     end
  end
end
