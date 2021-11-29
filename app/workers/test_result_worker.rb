require 'testlance_script'

class TestResultWorker
  include Sidekiq::Worker

  sidekiq_options queue: :scripts_exec, lock: :until_executed, lock_timeout: 2

  def perform(test_id)
    test = Test.find(test_id)

    result_value = test.calc_result

    ## Result for user statistic
    Result.create!(
      value: result_value,
      data: {
      # TODO user script
      # description
      # result in words
    }, test: test)
  end
end
