class Test < ApplicationRecord
  belongs_to :test_templates, class_name: 'TestTemplate'
  belongs_to :users, class_name: 'User'
  has_many :questions, foreign_key: 'tests_id'

  def template
    TestTemplate.find(test_templates_id)
  end

  def destroy_questions
    Question.where(tests_id: id).destroy_all
  end
end
