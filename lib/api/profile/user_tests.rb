require 'api/defaults'
module API
  module Profile
    class UserTests < Grape::API
      include Defaults
      format :json

      LIMIT = 20

      # auth

      params do
        optional :page, type: Integer
      end

      get 'user_tests' do
        page = !params[:page] ? 0 : params[:page]

        #TODO debug user
        tests = TestTemplate.where(author: 1).offset(page * LIMIT + [(page - 1), 0].max).limit(LIMIT)

        sleep 3
        present tests
      rescue => error
        error!(error, 400)
      end
    end
  end
end
