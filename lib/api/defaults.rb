module API
  module Defaults
    extend ActiveSupport::Concern

    included do
      def self.authorize!(role: :sub_admin, send_error: false)
        before do
          authenticated =
              case role
              when :sub_admin
                self.authenticated
              when :admin
                self.authenticated_admin
              end

          @user = User.new(role: :guest) if !authenticated && !send_error

          error!("403 Forbidden", 403) if !authenticated && send_error
        end
      end
    end
  end
end

