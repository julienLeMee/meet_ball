class Playground < ApplicationRecord
  has_many :games, dependent: :destroy
  has_one_attached :photo
  # validates :name, :adress, :description, presence: true
end
