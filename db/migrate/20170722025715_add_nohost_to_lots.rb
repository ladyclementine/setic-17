class AddNohostToLots < ActiveRecord::Migration[5.0]
  def change
  	#rails g migration addNohostToLots value_not_federated_nohost:float value_federated_nohost:float nohost_active:boolean
    #Host = accommodation
    add_column :lots, :value_not_federated_nohost, :float
    add_column :lots, :value_federated_nohost, :float
    add_column :lots, :nohost_active, :boolean, default: false
  end
end
