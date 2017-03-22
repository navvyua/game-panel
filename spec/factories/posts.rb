FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.characters(11) }
    text  { Faker::Lorem.paragraphs(5) }
    post_image { Faker::Avatar.image }
  end
end
