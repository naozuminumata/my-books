class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.integer :rating
      t.text :review
      t.integer :share

      t.timestamps
    end
  end
end
