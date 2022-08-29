class AddBadgesForUserBadges < ActiveRecord::Migration[7.0]
  def change
    add_reference :user_badges, :badge, index: true, foreign_key: true
  end
end
