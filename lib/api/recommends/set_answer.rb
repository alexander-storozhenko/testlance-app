require 'api/defaults'
require 'tests_helper'
module API
  module Recommends
    class SetAnswer < Grape::API
      include Defaults
      format :json

      authenticate!

      params do
        requires :minitest_id, type: Integer
        requires :answer_id, type: Integer
      end

      post 'set_answer' do
        minitest = MiniTest.find_by(_id: params[:minitest_id])
        exp = minitest.true_answer?(params[:answer_id]) ? EXP_VALUE : 0

        @user.update(experience: @user.experience + exp)

        present exp: exp
      end
    end
  end
end

