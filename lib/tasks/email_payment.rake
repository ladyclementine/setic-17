namespace :email_payment do
  desc "LEMBRAR O PAGAMENTO"

  task lembrar: :environment do
    users = User.select { |user| (user.payment.nil? || !user.payment.partially_paid?) && !user.lot_id.nil? }
    counter = 0;
    users.each do |user|
      UsersLotMailer.remember_payment(user).deliver_now
      p "Email enviado #{user.email}"
      counter += 1
    end
    p "#{counter} EMAILS ENVIADOs PARA LEMBRAR O PAGAMENTO"
  end

  #SE
  #rake -T | grep email_payment
  #rake email_payment:lembrar
  #223
  task lembrar_inscricao: :environment do
    users = User.with_deleted.where.not(deleted_at:nil).select { |user| user.lot_id == 1 }
    counter = 0;
    users.each do |user|
      UsersLotMailer.lembrar_inscricao(user).deliver_now
      p "Email enviado #{user.email}"
      counter += 1
    end
    p "#{counter} EMAILS ENVIADOs PARA LEMBRAR a inscrição"
  end

  #rake email_payment:bus
  #UsersLotMailer.alert_certificate(user).deliver_now
  task bus: :environment do
    users = User.pays
    counter = 0;
    users.each do |user|
      UsersLotMailer.bus(user).deliver_now
      p "Email enviado #{user.email}"
      counter += 1
    end
    p "#{counter} EMAILS ENVIADOs PARA LEMBRAR a inscrição"
  end

  task lembrar2: :environment do
    users = User.select { |user| (user.payment.nil? || !user.payment.partially_paid?) }
    counter = 0;
    users.each do |user|
      UsersLotMailer.remember_payment(user).deliver_now
      p "Email enviado #{user.email}"
      counter += 1
    end
    p "#{counter} EMAILS ENVIADOs PARA LEMBRAR O PAGAMENTO"
  end

  
end
