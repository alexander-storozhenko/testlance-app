require 'rails_helper'
require 'shared/access_token'
require 'shared/prepare_test'
require 'sidekiq/testing'

describe API::Tests do
  include_context 'admin'
  include_context 'prepare_test'
  let(:test_template) { create(:test_template, user: admin) }
  let(:json_result) { JSON.parse(response.body) }

  # 1. get: preview_info
  # 2. get: question first
  # 3. patch: set_answers
  # 4. get: results


  context 'type "one"' do
    let(:question_template_text_one) { create(:question_template, :one, test_template: test_template) }

    it 'successful' do
      question_template_text_one

      prepare(access_token)

      set_answers({ 2 => true }.to_json, 'one')

      get_result(1.0)
    end
  end

  context 'type "some"' do
    let(:question_template_text_one) { create(:question_template, :some, test_template: test_template) }

    it 'successful' do
      question_template_text_one

      prepare(access_token)

      set_answers({ 1 => true, 2 => true }.to_json, 'some')

      get_result(1.0)
    end
  end
end
