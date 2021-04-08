module API
  module Defaults
    extend ActiveSupport::Concern

    included do
      def self.authorize!(role: :sub_admin)
        before do
          authenticated =
              case role
              when :sub_admin
                self.authenticated
              when :admin
                self.authenticated_admin
              end

          error!("403 Forbidden", 403) unless authenticated
        end
      end
    end
  end
end

