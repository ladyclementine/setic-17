class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :event_id

      t.timestamps
    end
  end
end
