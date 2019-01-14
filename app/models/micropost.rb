class Micropost < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: {maximum: 255}
  
  has_many :likemicroposts
  has_many :liked_by_users, through: :likemicroposts, source: :user
end
