class AddPostImagesToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :post_images, :json
  end
end
