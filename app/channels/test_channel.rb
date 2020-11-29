class TestChannel < ApplicationCable::Channel
  def subscribed
    stream_from "test"
    p 'subscribed'
  end

  def unsubscribed
    p 'subscribed'
    # Any cleanup needed when channel is unsubscribed
  end
  def test
    p 'asd'
  end
end
