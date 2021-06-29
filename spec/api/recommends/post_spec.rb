require 'rails_helper'
require 'shared/access_token'

describe API::Recommends::Post do
  context 'when request' do
    include_context 'admin'

    let(:path) {'/api/v1/recommends/'}

    it 'return success' do
      expect(Recommend.count).to eq 0

      post path, headers: {'Access-Token': access_token}

      expect(response.status).to eq 201

      expect(Recommend.count).to eq 1
      expect(TestTemplate.count).to eq 1
      expect(QuestionTemplate.count).to eq 5
    end
  end
end
