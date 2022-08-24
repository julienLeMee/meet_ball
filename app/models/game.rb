class Game < ApplicationRecord
  belongs_to :playground
  belongs_to :user
end
