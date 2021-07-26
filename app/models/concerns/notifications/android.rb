module Notifications
  class Android
    def self.push(data)
      return unless data.blank?

      NotificationWorker.perform_async(data)
    end
  end
end