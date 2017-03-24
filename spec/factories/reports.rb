FactoryGirl.define do
  factory :report do
    user
    description { Faker::Lorem.sentence }

    trait :invalid do
      description nil
    end
  end
end
