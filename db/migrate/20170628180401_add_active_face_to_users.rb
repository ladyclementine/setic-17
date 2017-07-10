class AddActiveFaceToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :active_face, :boolean, default: false
  end
end
