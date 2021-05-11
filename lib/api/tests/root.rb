require_relative 'preview_info'
require_relative 'results'
require_relative 'delete'

module API
module Tests
  class Root < Grape::API
    namespace 'tests' do
        mount PreviewInfo
        mount Results
        mount Delete
      end
    end
  end
end