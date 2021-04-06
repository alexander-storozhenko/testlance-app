module API
  module Defaults
    extend ActiveSupport::Concern
    included do
      def self.authorize!
        before do
          oauth_token = session[:current_user]&.oauth_token
          if oauth_token && headers['Access Token'] && oauth_token == headers['Access Token']
            @user = session[:current_user]
          else
            error!(message: "Authorization error: ", code: 403)
          end
        end
      end
    end
  end
end