class Playground < ApplicationRecord
  has_many :games, dependent: :destroy
  # validates :name, :adress, :description, presence: true
end
