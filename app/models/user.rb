class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :games
  has_one_attached :photo
  has_many :players, dependent: :destroy
  has_many :user_badges, dependent: :destroy

  enum rank: {
    rank1: 0,
    rank2: 1,
    rank3: 2,
    rank4: 3,
    rank5: 4,
    rank6: 5
  }
end
