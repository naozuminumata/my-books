class AddDetailsToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :amazon_url, :string
    add_column :posts, :isbn_code, :string
  end
end
