module Recommends
  class MiniTest
    include Mongoid::Document

    field :title, type: String
    field :question, type: String
    field :answers, type: Array
    field :true_answer, type: Integer
    field :user_id, type: Integer
    field :active, type: Boolean, default: true

    def true_answer?(answer_id)
      answer_id == true_answer
    end
  end
end