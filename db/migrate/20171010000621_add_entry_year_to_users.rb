class AddEntryYearToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :entry_year, :string
  end
end
