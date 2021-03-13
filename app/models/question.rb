class Question < ApplicationRecord
  belongs_to :question_templates, class_name: 'QuestionTemplate'
  belongs_to :users, class_name: 'User'
  belongs_to :tests, class_name: 'Test', optional: true

  def answers_result
    true_answers & user_answers
  end

  def set_answers(answers)
    update(user_answers: answers)
  end
end