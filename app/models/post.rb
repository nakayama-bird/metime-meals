class Post < ApplicationRecord
  mount_uploaders :post_images, PostImageUploader

  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates :restaurant_name, presence: true, length: { maximum: 255 }
  validates :address, presence: true
  validates :body, presence: true, length: { maximum: 65_535 }
  validates :genre, presence: true
  validates :post_images, length: { maximum: 3 }

  enum genre: { japanese_food: 0, chinese_food: 1, western_food: 2, korean_food: 3, ethnic_food: 4,
                ramen: 10, curry: 11, cafe: 20, bar: 21, other: 99 }
  enum amount: { less_than_one_thousand: 0, one_thousand_level: 1, two_thousand_level: 2, theree_thousand_level: 3,
                 four_thousand_level: 4, five_thousand_level: 5, more_than_six_thousand: 6 }
  enum rating: { very_poor: 0, poor: 1, good: 2, better: 3, excellent: 4 }

  scope :with_tag, ->(tag_name) { joins(:tags).where(tags: { name: tag_name }) }
  scope :address_contain, ->(word) { where('posts.address LIKE ?', "%#{word}%") }
  scope :name_contain, ->(word) { where('posts.restaurant_name LIKE ?', "%#{word}%") }
  scope :by_genre, ->(genre) { where(genre:) }

  # geocodingについての設定
  geocoded_by :address
  after_validation :geocode, if: ->(obj) { obj.address.present? and obj.address_changed? }

  def save_with_tags(tag_names:)
    ActiveRecord::Base.transaction do
      self.tags = tag_names.map { |name| Tag.find_or_initialize_by(name: name.strip) }
      save!
    end
    true
  rescue StandardError
    false
  end

  # 編集時デフォルトで表示するためのメソッド
  def tag_names
    # NOTE: pluckだと新規作成失敗時に値が残らない(返り値がnilになる)
    tags.map(&:name).join(',')
  end
end
