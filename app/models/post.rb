class Post < ApplicationRecord
  validates :title, {presence: true}
  validates :review, {presence: true}

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def user
    User.find_by(id: self.user_id)
  end
end
