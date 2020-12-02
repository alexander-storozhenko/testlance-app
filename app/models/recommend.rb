class Recommend
  include Mongoid::Document
  include Mongoid::Enum

  field :user_id, type: Integer
  field :test_templates, type: Array

  def templates
    TestTemplate.where(id: test_templates)
  end
end