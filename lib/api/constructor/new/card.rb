require 'api/defaults'

module API
  module Constructor
    module New
      class Card < Grape::API
        include Defaults
        format :json
        authorize! send_error: true

        params do
          requires :title, type: String
          requires :sub_title, type: String
          requires :colors, type: String, regexp: /\#((\S){6}),\#((\S){6})/
          optional :image, type: File
        end

        post 'card' do
          content_type 'multipart/form-data'
          image = params[:image]
          colors = params[:colors].split(',')

          TestTemplate.where(author: @user, status: :constructing).destroy_all

          test_t = TestTemplate.create!(
              author: @user,
              status: :constructing,
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
          end

          test_t.save!

          sleep 2
          present image_url: test_t.image_url
        end
      end
    end
  end
end




