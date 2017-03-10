FactoryGirl.define do
  factory :news do
    title { Faker::Lorem.characters(11) }
    text  { Faker::Lorem.paragraphs(5) }
    news_image { Faker::Avatar.image }
  end
end
