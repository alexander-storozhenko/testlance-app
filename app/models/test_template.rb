class TestTemplate
  include Mongoid::Document

  # enum :type, [:radio, :checkbox, :text2image]

  field :title, type: String
  field :questions, type: Array, default: []

  def generate_user_test!(user_id)
    Test.create!(user_id: user_id, title: title, questions: questions)
  end
end
