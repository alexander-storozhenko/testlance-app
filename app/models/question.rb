class Question < ApplicationRecord
  belongs_to :question_template
  belongs_to :user
  belongs_to :tests, optional: true

  alias_attribute :template, :question_template

  def set_answers!(answers)
    update!(user_answers: answers)
  end

  def calculate_manual_result
    return if scripted?

    update_manual
  end

  private

  def update_manual
    result =
        case template.question_type
        when 'one'
          template.true_answers.first == user_answers.keys.first.to_i
        when 'some'
          answers = template.true_answers.map { |k, v| k if v }.reject { |e| e.blank? }
          real_answers = user_answers.map { |k, v| k if v }.reject { |e| e.blank? }

          (real_answers & answers).count == answers.count
        when 'n2n'
          template.true_answers.each { |k, v| return false unless user_answers[k] == v }

          true
        end

    update!(result: result)
  end
end