class TestTemplate < ApplicationRecord
  has_many :question_templates

  belongs_to :user
  after_create :set_random_colors

  def generate_user_test!(user_id)
    user = User.find(user_id)
    return unless user.tests.include?(id)

    Test.create!(user_id: user_id, title: title, questions: question_templates)
  end

  def set_random_colors
    update(colors: [random_color, random_color]) if colors.blank?
  end

  private

  def random_color
    "#" + ("%06x" % (rand * 0xffffff))
  end
end
