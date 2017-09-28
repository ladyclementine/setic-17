class CreateConfigs < ActiveRecord::Migration[5.0]
  def change
    create_table :configs do |t|
      t.string :name
      t.string :sigla
      t.string :logo
      t.string :conta
      t.string :agencia
      t.string :beneficiado
      t.string :banco
      t.string :local
      t.string :email

      t.timestamps
    end
  end
end
