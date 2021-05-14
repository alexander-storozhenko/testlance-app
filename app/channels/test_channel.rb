class TestChannel < ApplicationCable::Channel
  def subscribed
    return if params['id'].blank?

    stream_from "test:#{params['id']}"
  end

  def unsubscribed; end

  def self.send(msg)
    TestChannel.broadcast_to("test:#{params['id']}", "test")
  end
end

# TestChannel.broadcast_to 1, 'lol'
