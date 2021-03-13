class Result < ApplicationRecord
  belongs_to :tests, class_name: 'Test'
  belongs_to :users, class_name: 'User'

end
