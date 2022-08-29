class Badge < ApplicationRecord
  has_many :user_badges, dependent: :destroy
  BADGES = ["faiplay", "teamplayer", "sharpshoter", "mvp", "playmaker", "dribble god"]
end
