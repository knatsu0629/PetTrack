class LostPet < ApplicationRecord
  belongs_to :user

  enum gender: { male: 0, female: 1, unknown: 2 }
end



