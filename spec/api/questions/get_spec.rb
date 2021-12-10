require 'rails_helper'
require 'shared/access_token'

describe API::Questions::Get do
  context 'when response' do
    include_context 'admin'

    let(:path) { '/api/v1/questions/get' }

    let(:test_t) { create(:test_template) }
    let(:test) { create(:test, template: test_t) }
    let(:question_t_one) { create(:question_template, :one, test_template: test_t) }
    let(:question_one) {create(:question, number: 1, question_template: question_t_one, test: test)}

    #
    #  question -> question_template -> test_template
    #

    it 'successful first question' do
      test
      question_one

      get(path, headers: { 'Access-Token': access_token }, params: { test_id: test.id, question_number: 1, })

      result = JSON.parse(response.body)

      expect(result['question']['number']).to eq 1
      expect(result['question']['data']['question_type']).to eq 'one'
    end
  end
end
