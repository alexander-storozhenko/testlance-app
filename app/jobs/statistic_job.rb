# TODO to worker
class StatisticJob < ApplicationJob
  def perform
    views = Statistic::UserTestStatistic.views
    rating = Statistic::UserTestStatistic.rating

    TestTemplate.where(id: views.keys).each{|test_t| test_t.update(plays: test_t.plays + views[test_t.id])}

    TestTemplate.where(id: rating.keys).each{|test| test.update_rating(rating[test.id])}

    Statistic::UserTestStatistic.delete_views
  end
end