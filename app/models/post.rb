class Post < ApplicationRecord
  validates :title, {presence: true}
  validates :review, {presence: true}

  def user
    User.find_by(id: self.user_id)
  end
end
