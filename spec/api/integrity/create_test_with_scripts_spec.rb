require 'rails_helper'
require 'shared/access_token'
require 'shared/prepare_test'
require 'sidekiq/testing'

describe API::Tests do
  include_context 'admin'
  include_context 'prepare_test'

  let(:test_template) { create(:test_template, user: admin) }
  let(:json_result) { JSON.parse(response.body) }

  context 'type "one"' do
    let(:question_template_text_one) {
      create(:question_template,
             :one,
             scripted: true,
             data: { 'user_script': read_lua_script('api/integrity/lua_scripts/nonlinear_result') },
             test_template: test_template)
    }

    it 'successful' do
      question_template_text_one

      prepare(access_token)

      set_answers({ 2 => true }.to_json, 'one')

      get_result(0.7)
    end
  end
end
