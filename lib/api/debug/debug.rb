require 'api/defaults'
module API
  module Debug
    class Debug < Grape::API
      include Defaults
      format :json
      authorize! role: :admin

      get 'debug' do
        $redis.get("mykey")
      end
    end
  end
end



