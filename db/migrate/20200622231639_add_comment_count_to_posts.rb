class AddCommentCountToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :comment_count, :integer
  end
end
