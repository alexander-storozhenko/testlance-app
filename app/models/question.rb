class Question < ApplicationRecord
  include QuestionExecutorData

  belongs_to :question_template
  belongs_to :user
  belongs_to :test, optional: true

  alias_attribute :template, :question_template

  QUESTION_SCRIPT_DATA_VARS = [:Q_TITLE, :Q_DESCRIPTION, :USER_ANSWERS].freeze # TODO complete list

  def set_answers!(answers)
    update!(user_answers: answers)
  end

  def calculate_result
    template.scripted? ? calculate_result_with_script : calculate_result_by_default
  end

  private

  def calculate_result_with_script
    validated_data = validate_script_data(build_data(template, nil))

    executor = Testlance::Script::Executor.new(validated_data)
    executor.run!(template.data['user_script'].strip)
  end

  def calculate_result_by_default
    case template.question_type
    when 'one'
      template.true_answers.first == user_answers.keys.first.to_i ? 1 : 0
    when 'some'
      answers = template.true_answers.map { |k, v| k if v }.reject { |e| e.blank? }
      real_answers = user_answers.map { |k, v| k if v }.reject { |e| e.blank? }

      (real_answers & answers).count == answers.count ? 1 : 0
    when '1to1'
      template.true_answers.each { |k, v| return 0 unless user_answers[k] == v }

      1
    end
  end

  def build_data(question_t, _test_t)
    {
      Q_TITLE: {type: :string, value: question_t.title},
      Q_DESCRIPTION: {type: :string, value:question_t.subtitle},
      USER_ANSWERS: {type: :table, value: user_answers}
    }
  end

  def validate_script_data(data)
    raise StandardError, 'script data invalid' unless data.keys.sort == QUESTION_SCRIPT_DATA_VARS.sort

    data
  end
end