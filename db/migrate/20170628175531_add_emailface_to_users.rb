class AddEmailfaceToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :email_face, :string
  end
end
