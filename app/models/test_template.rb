class TestTemplate < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_many :question_templates, dependent: :destroy

  belongs_to :user
  after_create :set_random_colors

  alias_attribute :author, :user

  has_one_attached :image

  enum status: [:created, :constructing, :editing]

  #  avg: results.sum / results.count, if: result >= 0 and <= 5
  #  bool: results.where(result > 0).count
  enum result_calc_method: %i[avg bool]

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

  def update_rating(other_rating)
    return unless other_rating.count == 5

    new_rating = rating_raw.each_with_index.map { |value, index| value + other_rating[index] }
    update(likes: five_rating_value(new_rating), rating_raw: new_rating)
  end

  private

  def five_rating_value(rating)
    rating.each_with_index.sum { |value, index| value * (index + 1) } / rating.sum(0.0)
  end

  def random_color
    "#" + ("%06x" % (rand * 0xffffff))
  end
end
