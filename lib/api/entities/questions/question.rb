require_relative 'template'

module API
  module Entities
    module Questions
      class Question < Grape::Entity
        root :questions, :question

        expose :number, :user_answers

        expose :data, using: Entities::Questions::Template do |model|
          model.template
        end
      end
    end
  end
end


