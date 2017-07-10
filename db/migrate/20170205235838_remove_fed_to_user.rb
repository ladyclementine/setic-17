class RemoveFedToUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :federation_check, :boolean
    add_column :users, :federation_check, :integer, default: 1
  end
end
