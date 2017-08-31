class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.string :method
      t.float :price #PREÇO DO INGREÇO
      t.references :user, foreign_key: true
      t.boolean :status

      t.timestamps
    end
  end
end
