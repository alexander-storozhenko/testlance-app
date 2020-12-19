require 'api/defaults'
module API
  module Tests
    class Recommends < Grape::API
      include Defaults

      auth

      get 'recommends' do
        recommends = RecommendTemplate.where(user_id: session[:current_user].id)


        present recommends.map{|r| r.data}
      end
    end
  end
end