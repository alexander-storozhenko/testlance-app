user = User.create!(
    name: 'debug_user',
    password: 'root'
)

recommend = Recommend.create!(
    recommend_type: 'card'
)

test_t = TestTemplate.create!(
    title: 'example title',
    recommends: recommend,
    author: user
)

question_t = QuestionTemplate.create!(
    question_type: 'one',
    text: 'example text',
    answers: ['answer 1', 'answer 2', 'true answer'],
    true_answers: [2],
    test_templates: test_t
)
