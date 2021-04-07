require_relative 'user_tests'
require_relative 'user_data'
module API
  module Profile
    class Root < Grape::API
        namespace 'profile' do
            mount UserTests
            mount UserData
        end
     end
  end
end
