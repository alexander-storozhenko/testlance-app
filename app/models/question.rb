class Question
  include Mongoid::Document
  include Mongoid::Enum

  enum :type, [:checkbox, :radio, :button]

  field :test_id, type: Integer
  field :text, type: String
  field :answers, type: String

  field :true_answers, type: String
  field :user_answers, type: String #["apple"]

  def answers_result
    true_answers & user_answers
  end
end