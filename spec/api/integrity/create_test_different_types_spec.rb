require 'rails_helper'
require 'shared/access_token'

describe API::Tests do
  include_context 'admin'

  # let(:path) { '/api/v1/tests/results' }
  let(:test_template) { create(:test_template, user: admin) }
  let(:question_template_text_one) { create(:question_template, :one,  test_template: test_template, ) }
  let(:json_result) {JSON.parse(response.body)}
  # let(:test) { create(:test, test_template: test_template) }

  context 'when create test' do

    # 1. get: preview_info
    # 2. get: question first

    it 'type "one" with texts' do
      question_template_text_one

      path = '/api/v1/tests/preview_info'
      get path,
           headers: { 'Access-Token': access_token },
           params: {
             test_t_id: test_template.id
           }

      expect(response.status).to eq 200
      expect(Test.count).to eq 1
      expect(QuestionTemplate.count).to eq 1
      expect(Question.count).to eq 1

      path = '/api/v1/questions/get'
      test = Test.find(json_result['test_id'])

      get path,
          headers: { 'Access-Token': access_token },
          params: {
            test_id: test.id,
            question_number: 1,
          }

      json_result = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(json_result['question']['number']).to eq 1

      path = '/api/v1/questions/set_answers'
      patch path,
          headers: { 'Access-Token': access_token },
          params: {
            answers: {2 => true}.to_json,
            test_id: test.id,
            question_number: 1,
            question_type: 'one',
          }

      expect(response.status).to eq 200

      path = '/api/v1/tests/results'
      get path,
           headers: { 'Access-Token': access_token },
           params: { test_id: test.id }

      expect(response.status).to eq 200
      expect(TestResultWorker.jobs.size).to eq 1

      test.template.update!(result_calc_method: :bool)
      # simulate worker starting
      p test.calc_result





    end
  end
end
