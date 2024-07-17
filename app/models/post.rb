class Post < ApplicationRecord
  validates :restaurant_name, presence: true, length: {maximum: 255}
  validates :address, presence: true, length: {maximum: 255}
  validates :body, presence: true, length: {maximum: 65_535 }

  # geocodingについての設定
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  belongs_to :user
end
