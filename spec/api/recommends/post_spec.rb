require 'rails_helper'
require 'shared/access_token'

describe API::Recommends::Post do
  context 'when request' do
    include_context 'admin'

    let(:path) {'/api/v1/recommends/'}

    it 'return success' do
      post path, headers: {'Access-Token': access_token}

      expect(Recommend.count).to eq 5
      expect(response.status).to eq 201
    end
  end
end
