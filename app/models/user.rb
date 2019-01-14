class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :microposts
  has_many :relationships, class_name: 'Relationship', foreign_key: :user_id 
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user

  has_many :likemicroposts
  has_many :likes, through: :likemicroposts, source: :micropost
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def feed_microposts
    Micropost.where(user_id: self.following_ids + [self.id]) # 配列で揃える
  end
  
  def register_to_likes(micropost)
    self.likemicroposts.find_or_create_by(micropost_id: micropost.id)
  end
  
  def unregister_from_likes(micropost)
    unlike_micropost = self.likemicroposts.find_by(micropost_id: micropost.id)
    unlike_micropost.destroy if unlike_micropost
  end
  
  def already_registered?(micropost)
    self.likes.include?(micropost)
  end
end
