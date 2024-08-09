class AddRatingToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :rating, :integer, null: false,  default: 0
  end
end
