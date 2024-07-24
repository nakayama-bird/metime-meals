class CreateTaggings < ActiveRecord::Migration[7.1]
  def change
    create_table :taggings do |t|
      t.references :tag, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
    add_index :taggings, [:tag_id, :post_id], unique: true
  end
end
