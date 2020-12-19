module Recommends
  class MiniTestTemplate
    include Mongoid::Document

    field :title, type: String
    field :question, type: String
    field :answers, type: Array
    field :true_answer, type: Integer
  end
end
