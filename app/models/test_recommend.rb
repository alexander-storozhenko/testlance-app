class TestRecommend < ApplicationRecord
  belongs_to :test_template, dependent: :destroy
  belongs_to :recommend, dependent: :destroy
end