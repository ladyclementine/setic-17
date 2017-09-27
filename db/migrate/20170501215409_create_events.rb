class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.string :facilitator
      t.integer :limit
      t.text :description
      t.string :avatar
      t.float :price, precision: 8, scale: 2, default: 0.0
      t.integer :event_type_id
      t.boolean :is_shirt, default: false
      t.timestamps
    end
  end
end
