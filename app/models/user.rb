class User < ApplicationRecord
  authenticates_with_sorcery!
  mount_uploader :avatar, AvatarUploader
  attribute :gender, :integer
  attribute :age, :integer

  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:crypted_password] } # パスワードは6文字以上
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, uniqueness: true, allow_nil: true

  validates :email, uniqueness: true
  validates :name, presence: true, length: { maximum: 255 } # name要素を入力必須、255文字まで。

  has_many :posts, dependent: :destroy

  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_posts, through: :bookmarks, source: :post

  enum gender: { male: 0, female: 1 }
  enum age: { teens: 0, twenties: 1, thirties: 2, forties: 3, fifties: 4, over_sixties: 5 }

  def own?(object)
    object.user_id == id
  end

  def bookmark(post)
    bookmark_posts << post
  end

  def unbookmark(post)
    bookmark_posts.destroy(post)
  end

  def bookmark?(post)
    bookmark_posts.include?(post)
  end
end
