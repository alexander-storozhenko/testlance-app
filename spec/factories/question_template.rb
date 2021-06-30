FactoryBot.define do
  factory :question_template do
    title { 'question' }
    subtitle { 'question' }

    association :test_template, factory: :test_template

    trait :one do
      question_type { 'one' }
      answers {
        [
            "answer 1",
            "answer 2",
            "true answer"
        ]
      }

      true_answers { [2] }
      data { {title_type: "text", answers_type: "one,text"} }
    end

    trait :some do
      question_type { 'some' }
      answers {
        [
            "answer 1",
            "answer 2",
            "true answer"
        ]
      }

      data { {title_type: "text", answers_type: "some,text"} }

      true_answers { JSON.parse("{\"1\":\"true\", \"2\":\"true\"}") }
    end

    trait :n2n do
      question_type { 'n2n' }

      answers { {
          up: {
              'A': 'answer A',
              'B': 'answer B'
          },
          down: {
              '0': 'answer 1',
              '1': 'answer 2'
          }
      } }

      true_answers { {'A': 0} }

    end
  end
end


