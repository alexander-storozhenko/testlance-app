require 'api/defaults'
module API
  module Tests
    class Get < Grape::API
      include Defaults

      auth

      get ':id' do
        template = TestTemplate.find(params[:id])

        present template.generate_user_test!(session[:current_user].id)
      end
    end
  end
end