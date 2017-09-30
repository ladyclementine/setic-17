class AddToUserShirt < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :shirt, :string
  end
end
