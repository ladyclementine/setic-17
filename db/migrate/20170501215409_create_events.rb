class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.string :facilitator
      t.integer :limit
      t.datetime :start
      t.datetime :end
      t.text :description
      t.string :facilitator_image
      t.timestamps
    end
  end
end
