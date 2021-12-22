require 'api/defaults'
require 'tests_helper'

module API
  module Recommends
    class Index < Grape::API
      include Defaults
      format :json

      RECOMMENDS_COUNT = 10

      #authenticate!

      params do
        optional :page, type: Integer
      end

      get do
        page = params[:page].nil? ? 0 : params[:page]

        recommends = Recommend.offset(page * RECOMMENDS_COUNT + [(page - 1), 0].max).limit(RECOMMENDS_COUNT)

        result = recommends.map do |r|
          {type: r.recommend_type}.merge(tests: [JSON.parse(r.from_template.to_json)])
        end

        present result
      end
    end
  end
end
