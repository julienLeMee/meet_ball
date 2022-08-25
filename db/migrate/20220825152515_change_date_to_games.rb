class ChangeDateToGames < ActiveRecord::Migration[7.0]
  def change
    change_column(:games, :start_date, :datetime)
  end
end
