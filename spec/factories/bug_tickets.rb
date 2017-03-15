FactoryGirl.define do
  factory :bug_ticket do
    title Faker::StarWars.quote
    description Faker::Lorem.paragraph
    bug_image Faker::Avatar.image
  end
end
