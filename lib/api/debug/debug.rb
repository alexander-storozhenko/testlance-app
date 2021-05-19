require 'api/defaults'
module API
  module Debug
    class Debug < Grape::API
      include Defaults
      include ActionController::Live

      format :json

      get 'debug' do
        p stream

        sse = ActionController::Live::SSE.new(stream, retry: 300, event: "taskProgress")
        headers["Content-Type"] = "text/event-stream"

        sse.write(progress: 1)

        sleep 1
      end
    end
  end
end



