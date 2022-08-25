class ChangeEndTimeToGames < ActiveRecord::Migration[7.0]
  def change
    change_column(:games, :end_date, :datetime)
  end
end
