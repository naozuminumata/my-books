class User < ApplicationRecord
  has_secure_password

  validates :email,{uniqueness: true}
  validates :name, {presence: true}
  validates :email, {presence: true}
  
  def posts
    Post.where(user_id: self.id)
  end
end
