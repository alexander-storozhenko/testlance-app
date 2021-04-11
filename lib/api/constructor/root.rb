require_relative 'save_card'

module API
  module Constructor
    class Root < Grape::API
      namespace 'constructor' do
        mount SaveCard
      end
    end
  end
end


