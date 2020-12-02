require_relative 'index'
require_relative 'sign_in'
require_relative 'sign_up'

module API
module Users
  class Root < Grape::API
    namespace 'users' do
        mount Index
        mount SignIn
        mount SignUp
    end
  end
 end
end