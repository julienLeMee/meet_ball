class Badge < ApplicationRecord
  has_many :user_badges
  BADGES = ["faiplay", "teamplayer", "sharpshoter", "mvp", "playmaker", "dribble god"]
end
