class LostPet < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  enum gender: { male: 0, female: 1, unknown: 2 }

end



