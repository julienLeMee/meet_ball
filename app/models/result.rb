class Result < ApplicationRecord
  belongs_to :Game

  # validates :blue_score, uniqueness: true, numericality: { greater_than_or_equal_to: 0 }
  # validates :red_score, uniqueness: true, numericality: { greater_than_or_equal_to: 0 }
end
