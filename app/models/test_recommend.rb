class TestRecommend < ApplicationRecord
  belongs_to :recommend, dependent: :destroy
  belongs_to :test_template, dependent: :destroy
end