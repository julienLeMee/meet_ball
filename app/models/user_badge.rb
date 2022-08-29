class UserBadge < ApplicationRecord
  belongs_to :user
  belongs_to :badges
end
