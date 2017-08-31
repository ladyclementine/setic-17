class CreateShirts < ActiveRecord::Migration[5.0]
  def change
    create_table :shirts do |t|
      t.string :size
      t.float :price
      t.integer :limit

      t.timestamps
    end
  end
end
