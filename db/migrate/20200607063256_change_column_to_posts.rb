class ChangeColumnToPosts < ActiveRecord::Migration[5.2]
  def up
    change_column :posts, :amazon_url, :string, limit: 500
  end

  def down
    change_column :posts, :amazon_url, :string
  end
end
