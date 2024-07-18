class AddGenreToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :genre, :integer, null: false
  end
end
