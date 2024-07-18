# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ['Action', 'Comedy', 'Drama', 'Horror'].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# 一旦使用しないためコメントアウト
# p '==================== user post data create ===================='
# 10.times do |n|
#     User.create!(
#         name: "太郎#{n}",
#         email: "koko#{n}@email.com",
#         password: "password",
#         password_confirmation: "password"
#     )
# end

# user_ids = User.ids

# 20.times do |index|
#   user = User.find(user_ids.sample)
#   user.posts.create!(
#     restaurant_name: "タイトル#{index}",
#     address: "住所#{index}",
#     latitude: 50,
#     longitude: 50,
#     body: "本文#{index}",
#     genre: [0,1,2,3,4,10,11,20,21,99].sample
#     )
# end
