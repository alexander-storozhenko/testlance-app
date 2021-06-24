require 'rails_helper'

describe API::Users::Index do
  context 'when admin' do
    it 'test' do
      get '/api/v1/debug/debug'

      expect(response.status).to eq 200
    end
  end
end