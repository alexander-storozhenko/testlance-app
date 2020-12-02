module API
  module Defaults
    extend ActiveSupport::Concern
    included do
      def self.auth
        before do
          unless session[:current_user]&.authentication_token && headers['Token'] && session[:current_user].authentication_token == headers['Token']
            error!(message: "Authorization error: ", code: 403)
          end
        end
      end
    end
  end
end