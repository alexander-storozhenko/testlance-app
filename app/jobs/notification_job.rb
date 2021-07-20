# TODO to worker
class NotificationJob < ApplicationJob
  def perform(data)
    client = Exponent::Push::Client.new

    messages = [
        {
            to: "ExponentPushToken[#{ENV['EXPO_TOKEN']}]",
            title: data[:title],
            body: data[:body],
            sound: 'default',
            priority: 'high',
            channelId: 'my-channel',
        }
    ]

    handler = client.send_messages(messages)

    client.verify_deliveries(handler.receipt_ids)
  end
end