class Question < ApplicationRecord
  belongs_to :question_templates, class_name: 'QuestionTemplate'
  belongs_to :users, class_name: 'User'

  def answers_result
    true_answers & user_answers
  end

  def set_answer(user_id:, test_id:, answers:)
    return if test_id != self.test_id
    return if user_id != self.user_id

    update(user_answers: answers.map{|key, answer| {"#{key}":"#{answer}"}})
  end
end