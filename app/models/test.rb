class Test < ApplicationRecord
  belongs_to :test_templates,class_name:'TestTemplate'
  belongs_to :users, class_name:'User'
  has_many :questions
end
