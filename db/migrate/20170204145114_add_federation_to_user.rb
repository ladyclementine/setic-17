class AddFederationToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :federation_check, :boolean, default: false
  end
end
