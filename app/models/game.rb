class Game < ApplicationRecord
  belongs_to :playground
  belongs_to :user
  has_many_attached :photos
  has_many :players
  has_one :result
  validates :user, uniqueness: true

  enum team_size: {
    '1 v 1': 0,
    '2 v 2': 1,
    '3 v 3': 2,
    '4 v 4': 3
  }

  enum game_mode: {
    competitive: 0,
    casual: 1
  }
end
