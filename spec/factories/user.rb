FactoryBot.define do
  factory :user do
    email {'alex@aalex'}
    name {'alex'}
    password {'rootroot'}

    trait :admin do
      email {'admin@admin'}
      name {'admin'}
      role {'admin'}
    end
  end
end
