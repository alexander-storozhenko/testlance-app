class Test < ApplicationRecord
  belongs_to :test_template
  belongs_to :user
  has_many :questions

  alias_attribute :template, :test_template

  def destroy_questions
    Question.where(test_id: id).destroy_all
  end

  # TODO create parting answers
  def calc_result
    questions.select(&:result).count
  end
end
