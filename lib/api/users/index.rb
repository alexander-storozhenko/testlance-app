require 'api/defaults'
module API
  module Users
    class Index < Grape::API
      include Defaults

      auth

      get do
        present plain: env['rack.session'][:kek]
      end
    end
  end
end