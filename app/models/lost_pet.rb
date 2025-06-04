class LostPet < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :lost_pet_comments, dependent: :destroy
  has_many :lost_pet_tags, dependent: :destroy
  has_many :tags, through: :lost_pet_tags

  attr_accessor :tag_names

  enum gender: { male: 0, female: 1, unknown: 2 }
  def gender_label
    case gender
    when "male"
      "オス"
    when "female"
      "メス"
    when "unknown"
      "不明"
    end
  end

  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode, if: -> { will_save_change_to_address? && address.present? }

end