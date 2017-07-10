module Asaas
  class Utils
    def self.auth_from_env
      api_key = ENV['ASAAS_API_KEY']
      Asaas.api_key = api_key if api_key
    end

    def self.check_portions(installmentCount)
      m1 = vencimento_boletos['mes1'].split('/')
      m2 = vencimento_boletos['mes2'].split('/')
      m3 = vencimento_boletos['mes3'].split('/')
      m4 = vencimento_boletos['mes4'].split('/')

      mes1 = DateTime.new(m1[2].to_i, m1[1].to_i, m1[0].to_i, 23, 59, 59 , '-3')
      mes2 = DateTime.new(m2[2].to_i, m2[1].to_i, m2[0].to_i, 23, 59, 59 , '-3')
      mes3 = DateTime.new(m3[2].to_i, m3[1].to_i, m3[0].to_i, 23, 59, 59 , '-3')
      mes4 = DateTime.new(m4[2].to_i, m4[1].to_i, m4[0].to_i, 23, 59, 59 , '-3')

      today = DateTime.now


      if mes1>=today
        if installmentCount <=4
          installmentCount
        else
          4
        end
      elsif mes2>=today
        if installmentCount <=3
          installmentCount
        else
          3
        end
      elsif mes3>=today
        if installmentCount <=2
          installmentCount
        else
          2
        end
      elsif mes4>=today
        if installmentCount <=1
          installmentCount
        else
          1
        end
      end
    end

    def self.data_vencimento
      m1 = vencimento_boletos['mes1'].split('/')
      m2 = vencimento_boletos['mes2'].split('/')
      m3 = vencimento_boletos['mes3'].split('/')
      m4 = vencimento_boletos['mes4'].split('/')

      mes1 = DateTime.new(m1[2].to_i, m1[1].to_i, m1[0].to_i, 23, 59, 59 , '-3')
      mes2 = DateTime.new(m2[2].to_i, m2[1].to_i, m2[0].to_i, 23, 59, 59 , '-3')
      mes3 = DateTime.new(m3[2].to_i, m3[1].to_i, m3[0].to_i, 23, 59, 59 , '-3')
      mes4 = DateTime.new(m4[2].to_i, m4[1].to_i, m4[0].to_i, 23, 59, 59 , '-3')

      today = DateTime.now

      if mes1>=today
        "#{m1[2]}-#{m1[1]}-#{m1[0]}"
      elsif mes2>=today
        "#{m2[2]}-#{m2[1]}-#{m2[0]}"
      elsif mes3>=today
        "#{m3[2]}-#{m3[1]}-#{m3[0]}"
      elsif mes4>=today
        "#{m4[2]}-#{m4[1]}-#{m4[0]}"
      end

    end

    def self.vencimento_boletos
      config = YAML.load_file("#{Rails.root.to_s}/config/asaas.yml")
      config['vencimentos']
    end
  end
end
