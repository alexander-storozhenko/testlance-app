require 'api/defaults'
require 'tests_helper'
module API
  module Recommends
    class SaveInProfile < Grape::API
      include Defaults
      format :json

      authenticate!

      params do
        requires :minitest_id, type: Integer
        requires :answer_id, type: Integer
      end

      post 'save_in_profile' do

        {}
      end
    end
  end
end


