class Test < ApplicationRecord
  include TestResultMethods

  belongs_to :test_template
  belongs_to :user
  has_many :questions, dependent: :destroy
  has_one :result, dependent: :destroy

  alias_attribute :template, :test_template

  def destroy_questions
    Question.where(test_id: id).destroy_all
  end

  def calc_result
    # format: { number => result }
    results = questions.map { |question| { question.number => question.calculate_result } }

    return calc_result_by_default_method(results) unless template.scripted_result?

    data = build_data(results)


    executor = Testlance::Script::Executor.new(data)
    executor.run!(template.data['user_script'].strip)
  end

  private

  def calc_result_by_default_method(results)
    send("calc_#{template.result_calc_method}_result", results.map(&:values).flatten)
  end

  def build_data(results)
    {
      **results,
    }
  end
end
