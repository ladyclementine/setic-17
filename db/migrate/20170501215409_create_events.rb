class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.string :facilitator
      t.integer :limit
      t.text :description
      t.string :avatar
      t.string :price
      t.integer :type
      t.timestamps
    end
  end
end
