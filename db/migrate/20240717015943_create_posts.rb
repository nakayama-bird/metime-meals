class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :restaurant_name, null: false
      t.string :address, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.text :body, null: false
      t.integer :amount, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
