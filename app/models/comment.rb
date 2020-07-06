class Comment < ApplicationRecord
  validates :content, presence: true
  belongs_to :user
  belongs_to :post
  counter_culture :post
end
