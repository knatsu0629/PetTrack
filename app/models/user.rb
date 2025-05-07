class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :introduction, length: { maximum: 500 } 

  def guest_user?
    email == "guest@example.com"
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'ゲストユーザー'
      user.introduction = 'ゲストとしてログインしています。'
    end
  end

  # app/models/user.rb
  has_one_attached :avatar
  has_many :posts, dependent: :destroy
  has_many :lost_pets, dependent: :destroy
  has_many :comments, dependent: :destroy
end
