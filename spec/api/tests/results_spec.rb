require 'rails_helper'
require 'shared/access_token'

describe API::Tests::Results do
  context 'when request' do
    include_context 'admin'

    let(:path) { '/api/v1/tests/results' }
    let(:test_template) { create(:test_template, user: admin) }
    let(:test) { create(:test, test_template: test_template) }

    it 'return success' do
      get path, headers: {'Access-Token': access_token}, params: {test_id: test.id}

      expect(response.status).to eq 200
      expect(TestResultWorker).to have_enqueued_sidekiq_job(test.id)
    end
  end
end

