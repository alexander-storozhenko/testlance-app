require 'api/defaults'
require 'tests_helper'
require 'faker'
module API
  module Recommends
    class Post < Grape::API
      include Defaults
      format :json

      RECOMMENDS_COUNT = 10

      # auth

      params do
        optional :page, type: Integer
      end

      post do
        user = User.create!(
            name: Faker::Name.name,
            password: 'root'
        )
        recommend = Recommend.create!(
            recommend_type: 'card'
        )

        test_t = TestTemplate.create!(
            title: Faker::Lorem.sentence(word_count: 2, random_words_to_add: 1),
            sub_title: Faker::Lorem.sentence(word_count: 3, supplemental: true, random_words_to_add: 4),
            user: user
        )

        5.times do |q|
          QuestionTemplate.create!(
              question_type: 'one',
              text: Faker::Lorem.sentence(word_count: 2, random_words_to_add: 1),
              answers: ['answer 1', 'answer 2', 'true answer'],
              true_answers: [2],
              test_template: test_t
          )
        end

        present {}
      end
    end
  end
end

