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
    EXPIRED_LIMIT = 2.days.freeze

    RecommendItem = Struct.new(:timestamp, :list)

    # Simple algorithm in case when app don't know nothing about user.
    def popular_init_seq(limit: 10)
      TestTemplate
        .order(rating: :desc)
        .limit(limit)
        .map { |test_t| RecommendItem.new(DateTime.now, [test_t.id]) }
    end

    # Algorithm based by tags of visiting test.
    # Every test has some tags.
    # User has tag and count of visiting.
    # Function return the most crossing tests by tag in descent range.
    #
    # It is low speed operation. I'm not recommend to use function without *cache_result* flag!
    def popular_seq_by_tag!(user, limit: 10, cache_result: true)
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

      recommends = uniq_seq_by_id(ranged_set).sort_by { |_, v| v }

      if cache_result
        user.recommends << RecommendItem.new(DateTime.now, recommends)
        user.save!
      end

      recommends
    end

    # Recursive function for unique select of
    # test templates sequence by count.
    #
    # Return [{ id => set.count }, ...]
    def uniq_seq_by_id(set, result = [])
      return result if set.count == 0

      id = set.first.id
      result << { id => set.count { |v| v.id == id } }
      uniq_seq_by_id(set.select { |v| v.id != id }, result)
    end

    # destroy recommendations with creating time more than expired limit
    def destroy_expired_recommends(recommends)
      return if recommends.blank?

      recommends.map { |rec| rec unless expired_recommend?(rec.key) }
    end

    private

    def expired_recommend?(recommend_gen_time)
      DateTime.now - DateTime.parse(recommend_gen_time) > EXPIRED_LIMIT
    end
  end
end