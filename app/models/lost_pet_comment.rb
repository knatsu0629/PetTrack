class LostPetComment < ApplicationRecord
  belongs_to :user
  belongs_to :lost_pet

  validates :user, presence: true
  validates :comment, presence: true
end
