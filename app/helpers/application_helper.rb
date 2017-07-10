module ApplicationHelper
  def vencimento_boletos
    config = YAML.load_file("#{Rails.root.to_s}/config/asaas.yml")
    config['vencimentos']
  end
end
