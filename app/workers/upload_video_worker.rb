class UploadVideoWorker
  include Sidekiq::Worker

  sidekiq_options queue: :content_upload

  SEG_PATH = Rails.root.join('tmp/video_segs')
  SIZE = '30kb'

  def random_name
    SecureRandom.hex
  end

  def perform(user_id, video_tmp)
    video_path = video_tmp.path

    `split -b #{SIZE} #{video_path} #{SEG_PATH}/#{random_name}_.mp30kb`

    #TODO create video, segs db
  end
end
