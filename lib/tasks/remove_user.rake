namespace :remove_user do
  desc "Usários que não finalizaram o cadastro e nao selecionaram pagaram"  #rake remove_user:no_completed
  # heroku run rake remove_user:no_completed
  task no_completed: :environment do
    users = User.select { |user| user.completed.nil? }
    counter = 0;
    users.each do |user|
      p "Conta excluida #{user.email}"
      #user.destroy
      UsersLotMailer.destroy_account(user).deliver_now
      user.really_destroy!
      counter += 1
    end
    p "#{counter} contas excluidas"
  end

  #remover quem não selecionou o pagamento
  #menos a gti ne
  task no_payment_select: :environment do
    users = User.where.not("lower(split_part(junior_enterprise, ' ', 1)) = ?", "gti").select { |user| user.payment.nil? && !user.lot.nil? }
    counter = 0;
    users.each do |user|
      UsersLotMailer.destroy_account(user).deliver_now
      p "Conta excluida #{user.email}"
      user.destroy
      counter += 1
    end
    p "#{counter} contas excluidas"
  end

  #remover qm selecionou mas ñ pagou
  task no_payment_pay: :environment do
    users = User.where.not("lower(split_part(junior_enterprise, ' ', 1)) = ?", "gti").select { |user| !user.payment.nil? && !user.lot.nil? && user.payment.portion_paid==0 }
    counter = 0;
    users.each do |user|
      UsersLotMailer.destroy_account(user).deliver_now
      p "Conta excluida #{user.email}"
      user.destroy
      counter += 1
    end
    p "#{counter} contas excluidas"
  end


  #NOVA VERSÃO - RODAR FILA DE ESPERA -- ALL LOTS
  # SELECIONAR USERS QUE NÃO SELECIONARAM PAGAMENTO OU SELECIONARAM E NÃO PAGARAM
  task rodar_fila: :environment do
    users = User.select { |user| (user.payment.nil? || (!user.payment.nil? && user.payment.portion_paid==0 )) && !user.lot.nil? }
    users.each do |u|
      #u.payment.asaas_payments.destroy_all if !u.payment.nil?
      u.payment.destroy if !u.payment.nil?
      #DESCLASSIFICAR
      u.update_attributes(lot_id: nil, active: false)
    end
  end
end

# heroku run rake remove_user:no_completed  40 excluidos
