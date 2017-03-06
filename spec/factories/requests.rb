FactoryGirl.define do
  factory :request do
    user
    description { Faker::Lorem.sentence }

    trait :invalid do
      description nil
    end
  end
end
