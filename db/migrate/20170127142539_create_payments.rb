class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.string :method
      t.integer :portions, default: 1
      t.integer :portion_paid, default: 0
      t.float :price #PREÇO DO INGREÇO
      t.references :user, foreign_key: true
      t.string :user_asaas_id
      t.string :url_pagseguro
      t.string :status_pagseguro

      t.timestamps
    end
  end
end
