class Post < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  has_many :posts_tags, dependent: :destroy
  has_many :tags, through: :posts_tags

  attr_accessor :tag_names

  def tag_names=(names)
    self.tags = names.split(',').map do |name|
      Tag.find_or_create_by(name: name.strip)
    end
  end

  def tag_names
    tags.map(&:name).join(', ')
  end

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
  

  validates :title, presence: true
  validates :body, presence: true
end