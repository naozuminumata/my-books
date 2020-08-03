class ChangeDataRatingToPost < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :rating, :float
  end
end
