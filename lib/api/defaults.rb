module API
  module Defaults
    extend ActiveSupport::Concern
    included do
      def self.auth
        before do
          if session[:current_user]&.oauth_token && headers['Token'] && session[:current_user].oauth_token == headers['Token']
            @user = session[:current_user]
          else
            error!(message: "Authorization error: ", code: 403)
          end
        end
      end
    end
  end
end