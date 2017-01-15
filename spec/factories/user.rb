fake_password = Faker::Internet.password

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { fake_password }
    password_confirmation { fake_password }

    trait :invalid do
      email    nil
      password nil
    end
  end
end
