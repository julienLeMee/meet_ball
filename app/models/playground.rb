class Playground < ApplicationRecord
  has_many :games, dependent: :destroy
  has_many_attached :photos
  # validates :name, :adress, :description, presence: true
end
