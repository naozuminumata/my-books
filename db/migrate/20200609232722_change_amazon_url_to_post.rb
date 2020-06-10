class ChangeAmazonUrlToPost < ActiveRecord::Migration[5.2]
  def up
    change_column :posts, :amazon_url, :string, limit: 700
  end

  def down
    change_column :posts, :amazon_url, :string, limit: 500
  end
end
