class AddHighestRankToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :highest_rank, :integer
  end
end
