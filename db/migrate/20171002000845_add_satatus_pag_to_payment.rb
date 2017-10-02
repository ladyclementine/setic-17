class AddSatatusPagToPayment < ActiveRecord::Migration[5.0]
  def change
    add_column :payments, :status_pagseguro, :string
  end
end
