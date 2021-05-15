class RecommendsChannel < ApplicationCable::Channel
  def subscribed
    return if params['token'].blank?

    stream_from "recommends:#{params['token']}"
  end

  def unsubscribed; end

  def self.send(token, msg)
    RecommendsChannel.broadcast_to(token, msg)
  end
end
