require 'api/users/root'
require 'api/tests/root'
require 'api/questions/root'
require 'api/recommends/root'
module API
  class API < Grape::API

    helpers do
      def session
        env['rack.session']
      end
    end

    namespace 'v1' do
      mount Users::Root
      mount Tests::Root
      mount Questions::Root
      mount Recommends::Root
    end
  end
end