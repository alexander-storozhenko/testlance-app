# @created 2021-14-12
# @author Alexander Storozhenko

module Recommends
  module TestTemplates
    # This set of different algorithms of test recommendations to user.
    #
    # Test has some info for ranking:
    # * tags
    # * plays
    # * rating
    # * age
    #
    # User save his visiting in model _User_ (data['test_t_tags_visits']).
    #
    # functions must be called in async tasks only!

    THRESHOLD_RATING = 4.2.freeze
    THRESHOLD_PLAYS = 100.freeze

    # Simple algorithm in case when app don't know nothing about user.
    def popular_init_set(limit: 10)
      TestTemplate.order(rating: :desc).limit(limit)
    end

    # Algorithm based by tags of visiting test.
    # Every test has some tags.
    # User has tag and count of visiting.
    # Function return the most crossing tests by tag in descent range.
    #
    # It is low speed operation. I'm not recommend to use function without *cache_result* flag!
    def popular_set_by_tag!(user, limit: 10, cache_result: true)
      # data['test_t_tags_visits'] -> [{tag_number => visits_count}]
      user_visits = user.data['test_t_tags_visits']

      raise StandardError, 'User has not any visits' if !user_visits || user_visits.empty?

      sorted_visits = user_visits.to_a.sort_by { |v| v.first }.reverse
      ranged_set = sorted_visits.map do |visit_number, _|
        TestTemplate
          .where(':visit_number = ANY(tags)', visit_number: visit_number)
          .where("rating > #{THRESHOLD_RATING}")
          .order(plays: :desc)
          .limit(limit)
      end

      recommends = uniq_set_by_id(ranged_set).sort_by { |_, v| v }

      if cache_result
        user.data['test_t_recommend_ids'].concat(recommends)
        user.save!
      end

      recommends
    end

    # Recursive function for unique select of
    # test templates set by count.
    #
    # Return [{ id => set.count }, ...]
    def uniq_set_by_id(set, result = [])
      return result if set.count == 0

      id = set.first.id
      result << { id => set.count { |v| v.id == id } }
      uniq_set_by_id(set.select { |v| v.id != id }, result)
    end
  end
end