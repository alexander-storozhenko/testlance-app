module Statistic
  class UserTestStatistic < Statistic

    VIEWS_KEY = 'test_views_statistic'.freeze
    RATING_KEY = 'test_rating_statistic'.freeze

    def self.delete_views
      delete(VIEWS_KEY)
    end

    def self.delete_rating
      delete(RATING_KEY)
    end

    # format
    # test-id: views
    def self.views
      get_hash_all(VIEWS_KEY)
    end

    # format
    # test-id: [<count of 1>, <count of 2>, <count of 3>, <count of 4>, <count of 5>]
    def self.rating
      get_hash_all(RATING_KEY)
    end

    def self.increment_views(test_t_id)
      increment_value_in_hash(VIEWS_KEY, test_t_id)
    end

    def self.increment_rating(test_t_id)
      increment_value_in_hash(RATING_KEY, test_t_id)
    end
  end
end
