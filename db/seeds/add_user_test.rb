for i in 0..40
  user = User.new do |user|
    user.name = Faker::Name.name
    user.email = Faker::Internet.email
    user.password = '12345678'
    user.password_confirmation = '12345678'
    user.confirmed_at = DateTime.now
    user.confirmation_sent_at = DateTime.now
    user.active = true
    user.completed = true
    user.junior_enterprise = ["a.c.e.", "acens","adecon", "adm soluções", "agronômica", "aug", "cefet", "ciclo", "conalimentos", "conspeq","construtiva", "consultec", "diferencial","ejad","eject","ejudi","emzootec","engenius","epro","fcap","fea","fluxo","geocapta","geomaps","gti","i9","ime","impact","index","inoce","inova","inove","ipharma","jrs","kaizen","marisma","mecaniza","metal","pb","poli","proativa","produtiva","pro","proteq","retec","tecsys","trópicos","vale"
                              ].sample.titleize

    user.lot_id = 1
    user.paid_on = Time.now
    user.cpf = Faker::CPF.numeric 
    user.general_register = '205484084884'
    user.birthday = Faker::Date.birthday(18, 25) 
    user.gender = ['Masculino','Feminino'].sample
    user.phone = '(85) 99999-9999'
    user.federation = 'FEJECE'
    user.job =  ['Analista','Desenvolvedor','Presidente','Gerente de Projetos', 'RH', 'DAF'].sample
    user.university = ['USP','UECE','UNIFOR','UFRJ'].sample
    user.special_needs = ''
    user.address = Faker::Address.street_address 
    user.state = ['Ceara','Rio de Janeiro', 'São Paulo', 'Bahia'].sample
    user.transport_required = [true,false].sample
    user.city = ['Fortaleza','Rio de Janeiro', 'São Paulo', 'Salvador'].sample
    user.cep = '60000140'
    user.phone_parents = '(85) 99999-9999'
    user.name_parents   = Faker::Name.name
    user.federation_check = 1

  end
  if user.save
    user.payment ||= Payment.new do |payment|
      payment.method = "PagSeguro"
      payment.portions = 1
      payment.portion_paid = 1
      payment.price  = 350.0
      payment.status_pagseguro  = "Pago"
    end


    Rails.logger.info "#{user.name} foi adicionado"
  else
    Rails.logger.info "Não foi possível adicionar #{user.name}. Erros:\n\t #{user.errors.full_messages}"
  end
end


for i in 0..10
  user = User.new do |user|
    user.name = Faker::Name.name
    user.email = Faker::Internet.email
    user.password = '12345678'
    user.password_confirmation = '12345678'
    user.confirmed_at = DateTime.now
    user.confirmation_sent_at = DateTime.now
    user.active = true
    user.completed = true
    user.junior_enterprise = ["a.c.e.", "acens","adecon", "adm soluções", "agronômica", "aug", "cefet", "ciclo", "conalimentos", "conspeq","construtiva", "consultec", "diferencial","ejad","eject","ejudi","emzootec","engenius","epro","fcap","fea","fluxo","geocapta","geomaps","gti","i9","ime","impact","index","inoce","inova","inove","ipharma","jrs","kaizen","marisma","mecaniza","metal","pb","poli","proativa","produtiva","pro","proteq","retec","tecsys","trópicos","vale"
                              ].sample.titleize

    user.lot_id = 1
    user.paid_on = Time.now
    user.cpf = Faker::CPF.numeric 
    user.general_register = '205484084884'
    user.birthday = Faker::Date.birthday(18, 25) 
    user.gender = ['Masculino','Feminino'].sample
    user.phone = '(85) 99999-9999'
    user.federation = 'FEJECE'
    user.job =  ['Analista','Desenvolvedor','Presidente','Gerente de Projetos', 'RH', 'DAF'].sample
    user.university = ['USP','UECE','UNIFOR','UFRJ'].sample
    user.address = Faker::Address.street_address 
    user.state = ['Ceara','Rio de Janeiro', 'São Paulo', 'Bahia'].sample
    user.transport_required = [true,false].sample
    user.city = ['Fortaleza','Rio de Janeiro', 'São Paulo', 'Salvador'].sample
    user.cep = '60000140'
    user.phone_parents = '(85) 99999-9999'
    user.name_parents   = Faker::Name.name
    user.federation_check = 1

  end
  if user.save
    Rails.logger.info "#{user.name} foi adicionado"
  else
    Rails.logger.info "Não foi possível adicionar #{user.name}. Erros:\n\t #{user.errors.full_messages}"
  end
end

for i in 0..5
  user = User.new do |user|
    user.name = Faker::Name.name
    user.email = Faker::Internet.email
    user.password = '12345678'
    user.password_confirmation = '12345678'
    user.confirmed_at = DateTime.now
    user.confirmation_sent_at = DateTime.now


  end
  if user.save
    Rails.logger.info "#{user.name} foi adicionado"
  else
    Rails.logger.info "Não foi possível adicionar #{user.name}. Erros:\n\t #{user.errors.full_messages}"
  end
end

for i in 0..10
  user = User.new do |user|
    user.name = Faker::Name.name
    user.email = Faker::Internet.email
    user.password = '12345678'
    user.password_confirmation = '12345678'
    user.confirmed_at = DateTime.now
    user.confirmation_sent_at = DateTime.now
    user.active = true
    user.completed = true
    user.junior_enterprise = ["a.c.e.", "acens","adecon", "adm soluções", "agronômica", "aug", "cefet", "ciclo", "conalimentos", "conspeq","construtiva", "consultec", "diferencial","ejad","eject","ejudi","emzootec","engenius","epro","fcap","fea","fluxo","geocapta","geomaps","gti","i9","ime","impact","index","inoce","inova","inove","ipharma","jrs","kaizen","marisma","mecaniza","metal","pb","poli","proativa","produtiva","pro","proteq","retec","tecsys","trópicos","vale"
                              ].sample.titleize

    user.paid_on = Time.now
    user.cpf = Faker::CPF.numeric 
    user.general_register = '205484084884'
    user.birthday = Faker::Date.birthday(18, 25) 
    user.gender = ['Masculino','Feminino'].sample
    user.phone = '(85) 99999-9999'
    user.federation = 'FEJECE'
    user.job =  ['Analista','Desenvolvedor','Presidente','Gerente de Projetos', 'RH', 'DAF'].sample
    user.university = ['USP','UECE','UNIFOR','UFRJ'].sample
    user.address = Faker::Address.street_address 
    user.state = ['Ceara','Rio de Janeiro', 'São Paulo', 'Bahia'].sample
    user.transport_required = [true,false].sample
    user.city = ['Fortaleza','Rio de Janeiro', 'São Paulo', 'Salvador'].sample
    user.cep = '60000140'
    user.phone_parents = '(85) 99999-9999'
    user.name_parents   = Faker::Name.name
    user.federation_check = 1

  end
  if user.save
    Rails.logger.info "#{user.name} foi adicionado"
  else
    Rails.logger.info "Não foi possível adicionar #{user.name}. Erros:\n\t #{user.errors.full_messages}"
  end
end

