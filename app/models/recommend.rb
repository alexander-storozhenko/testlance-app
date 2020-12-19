class Recommend < ApplicationRecord
  belongs_to :test_templates, class_name: 'TestTemplate'

  def from_template
    case recommend_type
    when 'carousel'
      return
    when 'card'
      test_templates
    when 'minitest'
      MiniTest.find_by(_id: minitest_id)
    end
  end
end