class AddHostToPayments < ActiveRecord::Migration[5.0]
  def change
  	#Host = accommodation
  	#rails g migration addHostToPayments host:boolean
    add_column :payments, :host, :boolean, default: true
  end
end
