class QuestionTemplate < ApplicationRecord
  belongs_to :test_template

  enum question_type: %i[one]

  def generate_user_question!(user_id:, test_id:)
    user = User.find(user_id)

    return unless user.tests.include?(test_id)
    return unless user.tests[test_id].question_templates.include?(id)

    Question.create!(user_id: user_id, test_id: test_id)
  end

  def from_template(user_id, test_id)
    Question.create!(user_id: user_id, test_id: test_id, question_template_id: id)
  end
end