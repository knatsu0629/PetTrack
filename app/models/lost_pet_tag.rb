class LostPetTag < ApplicationRecord
  belongs_to :lost_pet
  belongs_to :tag
end
