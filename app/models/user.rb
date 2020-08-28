class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # has_secure_password

  serialize :preferences

  validates :email,{uniqueness: true}
  validates :name, {presence: true}
  validates :email, {presence: true}
  # validates :profile, length: { in: 1..150 }

  has_many :posts
  has_many :likes
  has_many :comments

  mount_uploader :image, ImageUploader
  
  # def posts
  #   Post.where(user_id: self.id)
  # end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
  end
end
