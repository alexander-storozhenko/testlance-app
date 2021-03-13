require_relative 'preview_info'
require_relative 'results'

module API
module Tests
  class Root < Grape::API
    namespace 'tests' do
        mount PreviewInfo
        mount Results
      end
    end
  end
end