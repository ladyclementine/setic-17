class RemoveCertificateToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :certificate, :boolean, default: false
  end
end
