class AddRegistrationToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :registration, :string
  end
end
