require 'rails_helper'
require 'shared/access_token'

describe API::Questions::SetAnswers do
  context 'when success responce' do
    include_context 'admin'

    let(:test_t) { create(:test_template) }
    let(:test) { create(:test, template: test_t) }

    let(:question_t_one) { create(:question_template, :one, test_template: test_t) }
    let(:question_t_some) { create(:question_template, :some, test_template: test_t) }
    let(:question_t_n2n) { create(:question_template, :n2n, test_template: test_t) }

    let(:question_one) { create(:question, number: 1, template: question_t_one, test_id: test.id) }
    let(:question_some) { create(:question, number: 1, template: question_t_some, test_id: test.id) }
    let(:question_n2n) { create(:question, number: 1, template: question_t_n2n, test_id: test.id) }

    let(:answers_one) { {'1': true}.to_json }
    let(:answers_one_right) { {'2': true}.to_json }
    let(:answers_some) { {'1': true, '3': true}.to_json }
    let(:answers_some_right) { {'1': true, '2': true}.to_json }
    let(:answers_n2n) { {'A': 2}.to_json }
    let(:answers_n2n_right) { {'A': 0}.to_json }

    let(:path) { '/api/v1/questions/set_answers' }

    context 'when answers right' do
      it 'question type one' do
        patch path,
              headers: {'Access-Token': access_token},
              params: {
                  question_number: question_one.number,
                  question_type: 'one',
                  answers: answers_one_right,
                  test_id: test.id.to_s
              }

        expect(response.status).to eq 200
        expect(TestTemplate.count).to eq 1
        expect(Test.count).to eq 1
        expect(QuestionTemplate.count).to eq 1
        expect(Question.count).to eq 1
        expect(Test.first.calc_result).to eq 1
        expect(Question.first.result).to eq true
        expect(Question.first.user_answers.to_json).to eq answers_one_right
      end

      it 'question type some' do
        patch path,
              headers: {'Access-Token': access_token},
              params: {
                  question_number: question_some.number,
                  question_type: 'some',
                  answers: answers_some_right,
                  test_id: test.id.to_s
              }

        expect(response.status).to eq 200
        expect(TestTemplate.count).to eq 1
        expect(Test.count).to eq 1
        expect(QuestionTemplate.count).to eq 1
        expect(Question.count).to eq 1
        expect(Test.first.calc_result).to eq 1
        expect(Question.first.result).to eq true
        expect(Question.first.user_answers.to_json).to eq answers_some_right
      end

      it 'question type n2n' do
        patch path,
              headers: {'Access-Token': access_token},
              params: {
                  question_number: question_n2n.number,
                  question_type: 'n2n',
                  answers: answers_n2n_right,
                  test_id: test.id.to_s
              }

        expect(response.status).to eq 200
        expect(TestTemplate.count).to eq 1
        expect(Test.count).to eq 1
        expect(QuestionTemplate.count).to eq 1
        expect(Question.count).to eq 1
        expect(Test.first.calc_result).to eq 1
        expect(Question.first.result).to eq true
        expect(Question.first.user_answers.to_json).to eq answers_n2n_right
      end
    end
  end
end

