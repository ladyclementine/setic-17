class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.integer :user_id
      t.integer :event_id
    end
    add_index :subscriptions, [:event_id, :user_id]
  end
end
