class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:crypted_password] } # パスワードは6文字以上
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, uniqueness: true, allow_nil: true

  validates :email, uniqueness: true
  validates :name, presence: true, length: { maximum: 255 } # name要素を入力必須、255文字まで。


  has_many :posts

  def own?(object)
    object.user_id == id
  end
end
