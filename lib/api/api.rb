require 'api/users/root'
require 'api/tests/root'
require 'api/questions/root'
require 'api/recommends/root'
require 'api/search/root'
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
      mount Search::Root
    end
  end
end