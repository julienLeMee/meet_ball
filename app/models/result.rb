class Result < ApplicationRecord
  belongs_to :game

  validates :game_id, uniqueness: true
end
