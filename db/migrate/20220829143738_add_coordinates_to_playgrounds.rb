class AddCoordinatesToPlaygrounds < ActiveRecord::Migration[7.0]
  def change
    add_column :playgrounds, :latitude, :float
    add_column :playgrounds, :longitude, :float
  end
end
