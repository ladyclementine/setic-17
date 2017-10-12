class AddAtributesToUser < ActiveRecord::Migration[5.0]
  def change

    add_column :users, :completed, :boolean
    add_column :users, :active, :boolean, default: true
    add_column :users, :name, :string
    add_column :users, :semester, :string
    add_column :users, :course, :string
    add_column :users, :university, :string
    add_column :users, :birthday, :string
    add_column :users, :cpf, :string
    add_column :users, :general_register, :string
    add_column :users, :certificate, :boolean, default: false

  end
end
