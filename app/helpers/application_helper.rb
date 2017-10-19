module ApplicationHelper
  def vencimento_boletos
    config = YAML.load_file("#{Rails.root.to_s}/config/asaas.yml")
    config['vencimentos']
  end

  def sizes_to_array
    sizes_array = [
      ['Selecione', nil],
      ['P'],
      ['M'],
      ['G'],
      ['GG']
    ]
  end
end
