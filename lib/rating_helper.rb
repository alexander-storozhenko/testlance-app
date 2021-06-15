module RatingHelper

  # require format [<count of 1>, <count of 2>, <count of 3>, <count of 4>, <count of 5>]
  def five_rating_value(rating)
    rating.each_with_index.sum{|value, index| value * (index+1)} / rating.sum(0.0)
  end
end
