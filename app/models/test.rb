class Test < ApplicationRecord
  belongs_to :test_template
  belongs_to :user
  has_many :questions

  def template
    TestTemplate.find(test_templates_id)
  end

  def destroy_questions
    Question.where(tests_id: id).destroy_all
  end
end
