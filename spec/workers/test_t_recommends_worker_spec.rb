require 'rails_helper'
require 'shared/access_token'

describe TestTemplatesRecommendsWorker do
  include_context 'admin'

  let(:test_template) { create(:test_template, user: admin) }
  let(:question_template_text_one) { create(:question_template, :one, test_template: test_template,) }
  let(:test) { create(:test, test_template: test_template) }

  context 'when start worker' do
    it 'creates initial sequence' do
      test_template

      Sidekiq::Testing.inline!

      described_class.perform_at(0)

      admin.reload

      expect(admin.recommends.count).to eq 1
      expect(admin.recommends.first['list'].first).to eq test_template.id
    end
  end
end




