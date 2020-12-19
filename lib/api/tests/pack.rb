require 'api/defaults'
module API
  module Tests
    class Pack < Grape::API
      include Defaults

      auth

      params do
        requires :pack_name, type: String
      end

      get 'pack' do
        templates = TestTemplate.where(pack_names: params[:pack_name])
        present templates
      end
    end
  end
end