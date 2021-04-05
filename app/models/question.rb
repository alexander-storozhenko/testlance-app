class Question < ApplicationRecord
  belongs_to :question_template
  belongs_to :user
  belongs_to :test, optional: true

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