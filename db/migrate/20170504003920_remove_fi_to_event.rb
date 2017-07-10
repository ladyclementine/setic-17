class RemoveFiToEvent < ActiveRecord::Migration[5.0]
  def change
    remove_column :events, :facilitator_image, :string
    add_column :events, :avatar, :string
  end
end
