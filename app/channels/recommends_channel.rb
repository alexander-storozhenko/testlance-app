class RecommendsChannel < ApplicationCable::Channel
  def subscribed
    return if params['id'].blank?

    stream_from "recommends:#{params['id']}"
  end

  def unsubscribed; end

  def self.send(id, msg)
    RecommendsChannel.broadcast_to(id, msg)
  end
end
