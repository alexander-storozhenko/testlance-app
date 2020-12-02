class Test
  include Mongoid::Document

  # enum :type, [:radio, :checkbox, :text2image]
  field :template_id, type: Integer
  field :user_id, type: Integer
  field :title, type: String
  field :questions, type: Array, default: [] # {1}
end
