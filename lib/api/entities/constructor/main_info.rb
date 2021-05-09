module API
  module Entities
    module Constructor
      class MainInfo < Grape::Entity
        root :test_templates, :test_template

        expose :title
        expose :sub_title
        expose :colors
        expose :image_url do |model|
          model.image_url
        end

      end
    end
  end
end

