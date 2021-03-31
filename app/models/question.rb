class Question < ApplicationRecord
  belongs_to :question_templates, class_name: 'QuestionTemplate'
  belongs_to :users, class_name: 'User'
  belongs_to :tests, class_name: 'Test', optional: true

  alias_attribute :template, :question_templates

  enum template: %w[one]

  def answers_result
    case template.type
    when :one
      template.true_answers == user_answers
    end
  end

  def set_answers(answers)
    update(user_answers: answers)
  end
end