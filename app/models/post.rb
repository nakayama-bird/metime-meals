class Post < ApplicationRecord
  validates :restaurant_name, presence: true, length: {maximum: 255}
  validates :address, presence: true, length: {maximum: 255}
  validates :body, presence: true, length: {maximum: 65_535 }
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :genre, presence: true
  enum genre: { japanese_food: 0, chinese_food: 1, western_food: 2, korean_food: 3, ethnic_food: 4,
ramen: 10, curry: 11, cafe: 20, bar: 21, other: 99}

  # geocodingについての設定
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  belongs_to :user
end
