class StatisticJob < ApplicationJob
  def perform
    hash = Statistic::UserTestStatistic.hash

    TestTemplate.where(id: hash.keys).each{|test_t| test_t.update(plays: test_t.plays + hash[test_t.id])}

    User.create! name: 'test', email: 't@t', password: '123456'

    Statistic::UserTestStatistic.delete_hash
  end
end