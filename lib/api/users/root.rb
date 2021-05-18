require_relative 'index'
require_relative 'sign_in'
require_relative 'sign_up'
require_relative 'sign_in_with_google'

module API
module Users
  class Root < Grape::API
    namespace 'users' do
        mount Index
        mount SignIn
        mount SignUp
        mount SignInWithGoogle
    end
  end
 end
end