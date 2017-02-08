fake_password = Faker::Internet.password

FactoryGirl.define do
  factory :user do
    name     { Faker::Name.first_name }
    email    { Faker::Internet.email }
    role     User.roles[:user]
    password { fake_password }
    password_confirmation { fake_password }

    trait :invalid do
      email    nil
      password nil
    end

    trait :admin do
      role User.roles[:admin]
    end
  end
end
