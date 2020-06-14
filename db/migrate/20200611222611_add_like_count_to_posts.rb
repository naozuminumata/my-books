class AddLikeCountToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :like_count, :integer
  end
end
