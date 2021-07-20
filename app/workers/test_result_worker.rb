require 'testlance_parser'

class TestResultWorker
  include Sidekiq::Worker

  sidekiq_options queue: :scripts_exec, lock: :until_executed, lock_timeout: 2

  def perform(test_id)
    test = Test.find(test_id)
    test_t = test.template
    questions_manual = test.questions.where(question_template: {scripted: false})
    questions_scripted = test.questions.where(question_template: {scripted: true})

    questions_manual.each { |question| question.calculate_manual_result }

    questions_scripted.each do |question|
      question_t = question.template

      executor = TestlanceParser::Executor.new(
          {
              title: test_t.title,
              description: test_t.sub_title,
              #TODO add others
          })

      result = executor.run!(question_t.data['user_script'].strip)

      Result.create!(data: {
          value: result,
          #TODO user script
          # description
          # result in words
      }, test_template: test_t)
    end
  end
end
