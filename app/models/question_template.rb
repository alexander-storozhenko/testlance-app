class QuestionTemplate < ApplicationRecord
  belongs_to :test_template

  enum question_type: {one: 0}

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