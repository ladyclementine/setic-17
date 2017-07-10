class AddPhoneToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :phone_parents, :string
    add_column :users, :name_parents, :string
  end
end
