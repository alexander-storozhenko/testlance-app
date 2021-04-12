require 'api/defaults'
module API
  module Profile
    class UserData < Grape::API
      include Defaults
      format :json

      authorize! send_error: true

      get 'user_data' do
        stats = @user.test_templates.each_with_object({plays: 0, likes: 0, likes_count: 0}) do |test, hsh|
          hsh[:plays] += test.plays
          hsh[:likes] += test.likes
          hsh[:likes_count] += 1
        end

        #stats = {plays: stats[:plays], likes: stats[:likes]  /  stats[:likes_count] * 5}

        result = {
            user_name: @user.name,
            account_type: 'free',
            avatar_url: @user.avatar_url
            #**stats
        }

        present result
      rescue => error
        error!(error, 400)
      end
    end
  end
end

