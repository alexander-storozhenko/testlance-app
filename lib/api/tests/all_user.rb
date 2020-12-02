require 'api/defaults'
module API
  module Tests
    class AllUser < Grape::API
      include Defaults

      auth

      get 'recommends/:user_id' do
        recommend = Recommend.find_by(user_id: params[:user_id])

        present recommend.templates
      end
    end
  end
end