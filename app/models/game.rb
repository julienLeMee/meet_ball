class Game < ApplicationRecord
  belongs_to :playground
  belongs_to :user
  has_many_attached :photos
end
