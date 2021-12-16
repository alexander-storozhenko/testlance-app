FactoryBot.define do
  factory :test_template do
    title {'test'}
    sub_title {'test test'}
    status {:created}
    rating {4.5}
    views {450}
    colors { %w(#000000 #ffffff) }
  end
end

