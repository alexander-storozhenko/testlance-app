class Recommend < ApplicationRecord
  has_many :test_recommends
  has_many :test_templates, through: :test_recommends

  def from_template
    case recommend_type
    when 'carousel'
      test_templates
    when 'card'
      test_template = test_templates.first
      JSON.parse(test_template.to_json).merge({author: test_template.author})
    when 'minitest'
      MiniTest.find_by(_id: minitest_id)
    end
  end
end