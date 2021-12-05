FactoryBot.define do
  factory :question_template do
    title { 'question' }
    subtitle { 'question' }
    scripted {false}

    association :test_template, factory: :test_template

    trait :img_title do
      title { 'https://lh3.googleusercontent.com/proxy/LX4h8lV2n5nSYyyuXyd9tCZAS3Pz93nD0p-J9oJos_mUVB3bm6IrZIXXiwokBH7KVugn_tpB8zO0tPnA_O7MMyGey9IkCUJkrQ4S0uSKTMMskl4-JE2XvUxX04NjAQ' }
      data { { title_type: "img" } }
    end

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
      data { { title_type: "text", answers_type: "one,text" } }
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

      data { { title_type: "text", answers_type: "some,text" } }

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

      true_answers { { 'A': 0 } }

    end
  end
end


