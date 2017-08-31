class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.datetime :subscribed_at
      t.integer :user_id
      t.integer :paymant_id
      t.integer :buyable_id
      t.string :buyable_type
    end
  	add_index :subscriptions, :buyable_id
  	add_index :subscriptions, :buyable_type
  end

end
