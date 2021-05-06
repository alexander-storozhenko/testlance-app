class QuestionTemplate < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :test_template

  after_update :check_title_type

  has_many_attached :answers_images
  has_one_attached :title_image

  enum question_type: {one: 0}

  scope :author, -> {test_template.author}

  def generate_user_question!(user_id:, test_id:)
    user = User.find(user_id)

    return unless user.tests.include?(test_id)
    return unless user.tests[test_id].question_templates.include?(id)

    Question.create!(user_id: user_id, test_id: test_id)
  end

  def from_template(user_id, test_id, number)
    Question.create!(user_id: user_id, test_id: test_id, number: number, question_template: self)
  end

  def constructing_question(user)
    test_template
  end

  def check_title_type
    case data[:title_type]
    when 'img'

    end
  end
end