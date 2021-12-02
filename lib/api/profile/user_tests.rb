require 'api/defaults'
module API
  module Profile
    class UserTests < Grape::API
      include Defaults
      format :json

      LIMIT = 20

      authenticate! send_error: true

      params do
        optional :page, type: Integer
      end

      get 'user_tests' do
        page = !params[:page] ? 0 : params[:page]

        tests = TestTemplate.where(author: @user).offset(page * LIMIT + [(page - 1), 0].max).limit(LIMIT)

        sleep 1
        present tests
      rescue => error
        error!(error, 400)
      end
    end
  end
end
