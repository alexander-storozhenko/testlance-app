require 'api/defaults'
require 'tests_helper'
require 'faker'
module API
  module Recommends
    class Post < Grape::API
      include Defaults
      format :json

      authorize! send_error: true
      only_development!

      RECOMMENDS_COUNT = 10

      params do
        optional :page, type: Integer
      end

      post do
        user = User.create!(
            name: Faker::Name.name,
            email: Faker::Internet.unique.email,
            password: 'rootroot'
        )

        test_t = TestTemplate.create!(
            title: Faker::Lorem.sentence(word_count: 2, random_words_to_add: 1),
            sub_title: Faker::Lorem.sentence(word_count: 3, supplemental: true, random_words_to_add: 4),
            user: user
        )

        1.times do |_|
          QuestionTemplate.create!(
              question_type: 'n2n',
              title: Faker::Lorem.sentence(word_count: 2, random_words_to_add: 1),
              answers: {
                  up: {
                      'A': Faker::Lorem.sentence(word_count: 1, random_words_to_add: 1),
                      'B': Faker::Lorem.sentence(word_count: 1, random_words_to_add: 1)
                  },
                  down: {
                      '0': Faker::Lorem.sentence(word_count: 1, random_words_to_add: 1),
                      '1': Faker::Lorem.sentence(word_count: 1, random_words_to_add: 1)
                  }
              },
              true_answers: {'A': 0},
              test_template: test_t,
              data:
                  {
                      title_type: "text",
                      answers_type: "n2n,text"
                  }
          )
        end

        1.times do |_|
          QuestionTemplate.create!(
              question_type: 'one',
              title: Faker::Lorem.sentence(word_count: 2, random_words_to_add: 1),
              answers: ['answer 1', 'answer 2', 'true answer'],
              true_answers: [2],
              test_template: test_t,
              data:
                  {
                      title_type: "text",
                      answers_type: "one,text"
                  }

          )
        end

        3.times do |_|
          QuestionTemplate.create!(
              question_type: 'some',
              title: Faker::Lorem.sentence(word_count: 2, random_words_to_add: 1),
              answers: ['answer 1', 'answer 2', 'true answer'],
              true_answers: JSON.parse("{\"1\":\"true\", \"2\":\"true\"}"),
              test_template: test_t,
              data:
                  {
                      title_type: "text",
                      answers_type: "some,text"
                  }

          )
        end

        test_t.set_options

        Recommend.create!(
            recommend_type: 'card',
            test_templates: [test_t]
        )

        present {}

      rescue => error
        error!(error, 400)
      end
    end
  end
end

