class AddColumnToConfigs < ActiveRecord::Migration[5.0]
  def change
    add_column :configs, :faq, :string
    add_column :configs, :close, :boolean
  end
end
