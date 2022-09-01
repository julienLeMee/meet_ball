class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :games
  has_one_attached :photo
  has_many :players, dependent: :destroy
  has_many :user_badges, dependent: :destroy
  has_many :badges, -> { distinct }, through: :user_badges
  has_many :played_games, through: :players, source: :game
  has_many :results, through: :games

  validates :username, presence: true, uniqueness: true
  validates :photo, presence: true

  enum rank: {
    rank1: 0,
    rank2: 1,
    rank3: 2,
    rank4: 3,
    rank5: 4,
    rank6: 5
  }

  enum highest_rank: {
    highest1: 0,
    highest2: 1,
    highest3: 2,
    highest4: 3,
    highest5: 4,
    highest6: 5
  }

  def all_games
    (games + played_games).uniq
  end

  def find_enum_from_rank
    #rank: @user.find_enum_from_rank

    User.ranks[rank]
  end

  def find_enum_from_highest_rank
    #rank: @user.find_enum_from_highest_rank

    User.highest_ranks[highest_rank]
  end
end
