FactoryGirl.define do
  factory :comment do
    text { Faker::Lorem.sentence }

    trait :invalid do
      text nil
    end
  end
end
