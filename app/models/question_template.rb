class QuestionTemplate < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :test_template

  has_many_attached :answers_images
  has_one_attached :title_image

  enum question_type: [:one, :some, :one2one]

  scope :author, -> {test_template.author}

  enum answers_type: [
    :one_text,
    :one_img,
    :one_img_text,
    :some_text,
    :some_img,
    :some_img_text,
    :one2one_text,
    :one2one_img,
    :one2one_img_text,
    :one2N_text,
    :one2N_img,
    :one2N_img_text,
  ]

  def title_image_url
    rails_blob_path(title_image, only_path: true) if title_image.attached?
  end

  def answer_image_url(id)
    rails_blob_path(answers_images[id], only_path: true) if answers_images.attached?
  end

  def generate_user_question!(user_id:, test_id:)
    user = User.find(user_id)

    return unless user.tests.include?(test_id)
    return unless user.tests[test_id].question_templates.include?(id)

    Question.create!(user_id: user_id, test_id: test_id)
  end

  def from_template(user_id, test_id, number)
    Question.create!(user_id: user_id, test_id: test_id, number: number, question_template: self)
  end
end