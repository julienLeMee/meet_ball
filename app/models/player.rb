class Player < ApplicationRecord
  belongs_to :game
  belongs_to :user

  validates :user, uniqueness: { scope: :game, message: 'Only one player per game' }

  enum team: {
    red: 0,
    blue: 1
  }
end
