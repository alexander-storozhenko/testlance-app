class StatisticJob < ApplicationJob
  def perform
    hash = Statistic::UserTestStatistic.hash

    TestTemplate.where(id: hash.keys).each{|test_t| test_t.update(plays: test_t.plays + items[test_t.id])}

    Statistic::UserTestStatistic.delete_hash
  end
end