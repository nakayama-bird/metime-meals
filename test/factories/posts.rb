FactoryBot.define do
  factory :post do
    sequence(:restaurant_name) { |n| "タイトル#{n}" }
    sequence(:body) { |n| "本文#{n}" }
    sequence(:address) { |n| "住所#{n}" }
    genre { [0, 1, 2, 3, 4, 10, 11, 20, 21, 99].sample }
    rating { [0, 1, 2, 3, 4].sample }
    latitude { 35.6895 }
    longitude { 139.6917 }
    association :user
  end
end
