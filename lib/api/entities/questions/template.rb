module API
  module Entities
    module Questions
      class Template < Grape::Entity
        root :question_templates, :question_template

        expose :id, :question_type, :number, :title, :subtitle, :answers, :data, :title_image_url
      end
    end
  end
end



