class Player < ApplicationRecord
  belongs_to :game
  belongs_to :user

  enum team: {
    red: 0,
    blue: 1
  }
end
