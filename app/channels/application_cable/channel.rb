module ApplicationCable
  class Channel < ActionCable::Channel::Base

    def test(data)
      p 'test'
    end
  end
end
