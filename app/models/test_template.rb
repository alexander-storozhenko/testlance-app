class TestTemplate < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_many :question_templates, dependent: :destroy

  belongs_to :user
  after_create :set_random_colors

  alias_attribute :author, :user

  has_one_attached :image

  enum status: [:created, :constructing]

  def image_url
    rails_blob_path(image, only_path: true) if image.attached?
  end

  def generate_user_test!(user_id)
    user = User.find(user_id)
    return unless user.tests.include?(id)

    Test.create!(user_id: user_id, title: title, questions: question_templates)
  end

  def set_random_colors
    update(colors: [random_color, random_color]) if colors.blank?
  end

  def set_options(**args)
    self.options = {
        question_count: question_templates.count,
        author_name: author.name,
        **args
    }
    save!
  end

  private

  def random_color
    "#" + ("%06x" % (rand * 0xffffff))
  end
end
