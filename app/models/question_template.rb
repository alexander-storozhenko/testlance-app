class QuestionTemplate < ApplicationRecord
  belongs_to :test_templates, class_name: 'TestTemplate'

  alias_attribute :test_template_id, :test_templates_id

  def generate_user_question!(user_id:, test_id:)
    user = User.find(user_id)

    return unless user.tests.include?(test_id)
    return unless user.tests[test_id].question_templates.include?(id)

    Question.create!(users_id: user_id, tests_id: test_id)
  end

  def from_template(user_id, test_id)
    Question.create!(users_id: user_id, tests_id: test_id, question_templates_id: id)
  end
end