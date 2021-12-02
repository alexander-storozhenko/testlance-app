require 'rails_helper'
require 'shared/access_token'
require 'sidekiq/testing'

describe API::Tests do
  include_context 'admin'

  let(:test_template) { create(:test_template, user: admin) }
  let(:json_result) { JSON.parse(response.body) }

  # 1. get: preview_info
  # 2. get: question first
  # 3. patch: set_answers
  # 4. get: results

  def preparing
    # preview_info
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

    # question first
    path = '/api/v1/questions/get'
    @test = Test.find(json_result['test_id'])

    get path,
        headers: { 'Access-Token': access_token },
        params: {
          test_id: @test.id,
          question_number: 1,
        }

    json_result = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(json_result['question']['number']).to eq 1
  end

  def set_answers(answers, type)
    path = '/api/v1/questions/set_answers'
    patch path,
          headers: { 'Access-Token': access_token },
          params: {
            answers: answers,
            test_id: @test.id,
            question_number: 1,
            question_type: type,
          }

    expect(response.status).to eq 200
  end

  def get_result(desired_result)
    # need for starting job
    Sidekiq::Testing.inline!

    path = '/api/v1/tests/results'
    get path,
        headers: { 'Access-Token': access_token },
        params: { test_id: @test.id }

    expect(response.status).to eq 200
    expect(@test.result.value).to eq desired_result
  end

  context 'type "one"' do
    let(:question_template_text_one) { create(:question_template, :one, test_template: test_template) }

    it 'successful' do
      question_template_text_one

      preparing

      set_answers({ 2 => true }.to_json, 'one')

      get_result(1.0)
    end
  end

  context 'type "some"' do
    let(:question_template_text_one) { create(:question_template, :some, test_template: test_template) }

    it 'successful' do
      question_template_text_one

      preparing

      set_answers({ 1 => true, 2 => true }.to_json, 'some')

      get_result(1.0)
    end
  end
end
