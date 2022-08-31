class RemoveBadgesFromUserBadges < ActiveRecord::Migration[7.0]
  def change
    remove_reference :user_badges, :badges, null: false, foreign_key: true
  end
end
