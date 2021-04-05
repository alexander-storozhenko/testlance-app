class Question < ApplicationRecord
  belongs_to :question_template
  belongs_to :user
  belongs_to :tests, optional: true

  alias_attribute :template, :question_template

  def result
    case template.question_type
    when 'one'
      template.true_answers.first == user_answers.first
    end
  end

  def set_answers(answers)
    update(user_answers: answers)
  end
end