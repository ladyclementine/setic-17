class RemoveNameToRooma < ActiveRecord::Migration[5.0]
  def change
    remove_column :rooms, :name, :string
    add_column :rooms, :name, :string, array: true
  end
end
