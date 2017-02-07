FactoryGirl.define do
  factory :character do
    user
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    age        { Faker::Number.between(18, 60) }
    biography  { Faker::Lorem.paragraph }
    status     0
    cash       { Faker::Number.between(500, 2000) }
    bank       { Faker::Number.between(500, 2000) }

    trait :invalid do
      first_name nil
    end
  end
end
