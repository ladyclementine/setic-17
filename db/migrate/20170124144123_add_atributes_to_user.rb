class AddAtributesToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :string
    add_column :users, :cpf, :string
    add_column :users, :general_register, :string
    add_column :users, :birthday, :date
    add_column :users, :gender, :string
    add_column :users, :phone, :string
    add_column :users, :federation, :string
    add_column :users, :junior_enterprise, :string
    add_column :users, :job, :string
    add_column :users, :university, :string
    add_column :users, :completed, :boolean
    add_column :users, :special_needs, :text
    add_column :users, :active, :boolean, default: true
    add_column :users, :lot_id, :integer
    add_column :users, :avatar, :string
    add_column :users, :paid_on, :datetime
    add_column :users, :room_id, :integer
    add_column :users, :address, :text
    add_column :users, :state, :string
    add_column :users, :transport_required, :boolean, default: false
    add_column :users, :transport_local, :string
    add_column :users, :city, :string
    add_column :users, :street, :string
    add_column :users, :cep, :string
  end
end
