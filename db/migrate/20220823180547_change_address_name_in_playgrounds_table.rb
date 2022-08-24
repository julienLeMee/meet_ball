class ChangeAddressNameInPlaygroundsTable < ActiveRecord::Migration[7.0]
  def change
    rename_column :playgrounds, :adress, :address
  end
end
