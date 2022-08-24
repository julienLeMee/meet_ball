class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.integer :team
      t.boolean :confirmed_results
      t.references :game, null: false, foreign_key: true
      t.references :playground, null: false, foreign_key: true

      t.timestamps
    end
  end
end
