require 'rails_helper'
require 'shared/access_token'

describe TestResultWorker do
  include_context 'admin'

  let(:test_template) { create(:test_template, user: admin) }
  let(:question_template_text_one) { create(:question_template, :one,  test_template: test_template, ) }
  let(:test) { create(:test, test_template: test_template) }

  context 'when start worker' do
    it 'creates result' do
      question_template_text_one

      described_class.new.perform(test.id)

      expect(described_class.jobs.size).to eq 1
      expect(Result.count).to eq 1
    end
  end
end



