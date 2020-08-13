class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  has_secure_password

  validates :email,{uniqueness: true}
  validates :name, {presence: true}
  validates :email, {presence: true}
  validates :profile, length: { in: 1..150 }

  has_many :posts
  has_many :likes
  has_many :comments

  mount_uploader :image, ImageUploader
  
  def posts
    Post.where(user_id: self.id)
  end
end
