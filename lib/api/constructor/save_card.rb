require 'api/defaults'
module API
  module Constructor
    class SaveCard< Grape::API
      include Defaults

      authorize! send_error: true

      params do
        requires :image, type: File
        requires :colors, type: String
      end

      post 'save_card' do
        content_type 'multipart/form-data'
        image = params[:image]

        attachment = {
            filename: image[:filename],
            type: image[:type],
            headers: image[:head],
            tempfile: image[:tempfile]
        }

        test_t = TestTemplate.create(author: @user)

        test_t.image = ActionDispatch::Http::UploadedFile.new(attachment)

        test_t.save!

        present image_url: test_t.image_url
      end
    end
  end
end




