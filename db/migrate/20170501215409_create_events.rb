class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.string :facilitator
      t.integer :limit
      t.text :description
      t.string :avatar
      t.string :price
      t.integer :event_type_id
      t.boolean :is_shirt, default: false
      t.timestamps
    end
  end
end
