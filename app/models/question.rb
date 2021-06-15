class Question < ApplicationRecord
  belongs_to :question_template
  belongs_to :user
  belongs_to :tests, optional: true

  alias_attribute :template, :question_template

  def result
    case template.question_type
    when 'one'
      template.true_answers.first == user_answers.keys.first.to_i
    when 'some'
      answers = template.true_answers.map { |k, v| k if v }.reject { |e| e.blank? }
      real_answers = user_answers.map { |k, v| k if v }.reject { |e| e.blank? }

      #TODO mb use other system of calculating points
      # now using: all test failing if one error
      (real_answers & answers).count == answers.count

      # format
      # {
      #   0:'B'
      #   1:'A'
      #   2:'C'
      #   3:'E'
      #   4:'D'
      # }
    when 'n2n'
      template.true_answers.each {|k, v| return false unless user_answers[k] == v}

      true
    end
  end

  def set_answers!(answers)
    update!(user_answers: answers)
  end
end