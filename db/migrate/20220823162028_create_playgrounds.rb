class CreatePlaygrounds < ActiveRecord::Migration[7.0]
  def change
    create_table :playgrounds do |t|
      t.string :name
      t.string :adress
      t.string :description

      t.timestamps
    end
  end
end
