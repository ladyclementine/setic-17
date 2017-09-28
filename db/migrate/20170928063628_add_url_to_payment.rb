class AddUrlToPayment < ActiveRecord::Migration[5.0]
  def change
    add_column :payments, :url_pagseguro, :string
  end
end
