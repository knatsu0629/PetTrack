class Tag < ApplicationRecord
  has_many :posts_tags, dependent: :destroy
  has_many :posts, through: :posts_tags

  has_many :lost_pet_tags, dependent: :destroy
  has_many :lost_pets, through: :lost_pet_tags

  validates :name, presence: true, uniqueness: true
end
