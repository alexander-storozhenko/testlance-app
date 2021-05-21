require 'api/defaults'

module API
  module Constructor
    module Edit
      class Card < Grape::API
        include Defaults
        format :json

        authorize! send_error: true

        params do
          requires :test_t_id, type: Integer
          requires :title, type: String
          requires :sub_title, type: String
          requires :colors, type: String, regexp: /\#((\S){6}),\#((\S){6})/
          optional :image, type: File
        end

        patch 'card' do
          content_type 'multipart/form-data'
          image = params[:image]
          colors = params[:colors].split(',')

          test_t = TestTemplate.find_by(id: params[:test_t_id])

          raise 'Test not exists' unless test_t

          test_t.update!(
              author: @user,
              status: :editing,
              title: params[:title],
              sub_title: params[:sub_title],
              colors: colors
          )

          if image
            attachment = {
                filename: image[:filename],
                type: image[:type],
                headers: image[:head],
                tempfile: image[:tempfile]
            }

            test_t.image = ActionDispatch::Http::UploadedFile.new(attachment)
            test_t.save!
          end

          sleep 2
          present image_url: test_t.image_url
        end
      end
    end
  end
end




