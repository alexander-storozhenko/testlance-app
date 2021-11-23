module TestResultMethods
  extend ActiveSupport::Concern

  def calc_avg_result(results_values)
    results_values.sum.fdiv(results_values.count)
  end

  def calc_bool_result(results_values)
    results_values.count(&:positive?)
  end
end
