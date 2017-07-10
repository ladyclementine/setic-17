class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.string :name, array: true, default: nil
      t.integer :capacity
      t.integer :number
      t.text :extra_info
      t.integer :hotel_id
      t.boolean :air, default: true
      t.timestamps
    end
  end
end
