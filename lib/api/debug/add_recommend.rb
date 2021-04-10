require 'api/defaults'
module API
  module Debug
    class AddRecommend < Grape::API
      include Defaults
      format :json
      #authorize! role: :admin

      get do
        #content_type 'image/png'
        User.find(1).avatar_url

      end
    end
  end
end


