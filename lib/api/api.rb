require 'api/users/root'
require 'api/tests/root'

module API
  class API < Grape::API

    helpers do
      def session
        env['rack.session']
      end
    end
    mount Users::Root
    mount Tests::Root
  end
end