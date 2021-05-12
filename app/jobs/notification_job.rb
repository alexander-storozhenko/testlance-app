class NotificationJob < ApplicationJob
  def perform(data)
    client = Exponent::Push::Client.new

    messages = [
        {
            to: "ExponentPushToken[#{data[:token]}]",
            title: data[:title],
            body: data[:body]
        }
    ]

    handler = client.send_messages(messages)

    client.verify_deliveries(handler.receipt_ids)
  end
end

# NotificationJob.perform_later(token: 'NBSxpAIRpkRRf4cwyMDKyT', body: 'KEK')