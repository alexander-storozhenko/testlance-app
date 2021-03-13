require 'api/defaults'
require 'tests_helper'
module API
  module Search
    class Get < Grape::API
      include Defaults
      format :json

      RESULTS_MAX_COUNT = 30

      # auth

      params do
        requires :fragment, type: String
      end

      get 'get' do
        fragment = "%#{params[:fragment].strip.downcase}%"

        sleep 1

        break {} if params[:fragment].blank?

        card_results = TestTemplate
                           .where('lower(title) LIKE ? OR lower(sub_title) LIKE ?', fragment, fragment).limit(RESULTS_MAX_COUNT)
                           .map{|template| JSON.parse(template.to_json).merge({author: template.author.name})}
        #
        user_results = User.where('lower(name) LIKE ?', fragment).limit(RESULTS_MAX_COUNT)
        p card_results
        present cards: card_results, authors: user_results
        rescue
          error!(message: "Bad request", code: 400)
      end
    end
  end
end

