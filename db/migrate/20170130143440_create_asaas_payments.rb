class CreateAsaasPayments < ActiveRecord::Migration[5.0]
  def change
    create_table :asaas_payments do |t|

      t.string :payment_asaas_id
      t.string :installment #Identificador único do parcelamento (quando cobrança parcelada)
      t.string :custumer_id
      t.string :boleto_url
      t.string :fatura_url
      t.string :status, default: "PENDING"
      t.string :description
      t.datetime :client_payment_date

      t.timestamps
    end
  end
end
