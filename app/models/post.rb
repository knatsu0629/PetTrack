class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
  

  validates :title, presence: true
  validates :body, presence: true
end