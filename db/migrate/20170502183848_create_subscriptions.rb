class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.datetime :subscribed_at
      t.integer :user_id
      t.integer :event_id
    end
  end
end
