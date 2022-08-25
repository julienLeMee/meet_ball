class CreateResults < ActiveRecord::Migration[7.0]
  def change
    create_table :results do |t|
      t.integer :red_score
      t.integer :blue_score
      t.boolean :status
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
