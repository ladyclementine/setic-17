class UsersLotMailer < ApplicationMailer
  def send_antecipated_lot(user, lot)
    @user = user
    @lot = lot
    mail to: user.email, subject: "EFEJ 2017 - Link de cadastro antecipado no #{lot.name}"
  end

  def bus(user)
    @user = user
    mail to: user.email, subject: "[EFEJ 2017] - TRIPULAÇÃO, IÇAR ÂNCORAS!"
  end

  def certificate(user)
    @user = user
    mail to: user.email, subject: "[EFEJ 2017] - Certificado Liberado"
  end

  def alert_certificate(user)
    @user = user
    mail to: user.email, subject: "[EFEJ 2017] - Atenção Tripulantes do EFEJ 17!"
  end


  def event(user)
    @days = Event.join_events_by_time
    @user = user
    mail to: user.email, subject: "[EFEJ 2017] - Confira sua programação."
  end

  def destroy_account(user)
    @user = user
    mail to: user.email, subject: "[EFEJ 2017] - Você perdeu sua vaga :/"
  end

  def allocated_on_third_lot(user)
    @user = user
    mail to: user.email, subject: "EFEJ 2017 - Você entrou para o #{lot.name}!"
  end

  def allocated(user)
    @user = user
    mail to: user.email, subject: "EFEJ 2017 - Você está no lote #{user.lot.number}"
  end

  def not_allocated(user)
    @user = user
    mail to: user.email, subject: "EFEJ 2017 - Fique atento a lista de espera!"
  end

  def choose_payment(user)
    @user = user
    mail to: user.email, subject: "EFEJ 2017 - Você pode nos dar uma mãozinha?"
  end

  #UsersLotMailer.special_needs(user).deliver_now
  def special_needs(user)
    @user = user
    mail to: user.email, subject: "EFEJ 2017 - Melhor Experiência"
  end

  #patrick
  def remember_payment(user)
    @user = user
    unless @user.name.nil?
      mail to: user.email, subject: "[EFEJ 2017] Última chamada, o navio vai zarpar!"
    else
      mail to: user.email, subject: "[EFEJ 2017] Última chamada, o navio vai zarpar!"
    end
  end

  #patrick #heroku run rake email_payment:lembrar_inscricao
  def lembrar_inscricao(user)
    @user = user
    mail to: user.email, subject: "Garanta sua vaga no EFEJ 2017!"
  end

  def waiting_list_into_lot_2(user)
    @user = user
    mail to: user.email, subject: "EFEJ 2017 - Sempre há uma segunda chance!"
  end

  def remember_lot_3_payment(user)
    @user = user
    mail to: user.email, subject: "EFEJ 2017 - Não esqueça o pagamento"
  end

  def remember_payment_2(user)
    @user = user
    mail to: user.email, subject: "EFEJ 2017 - Não esqueça do pagamento"
  end

  def remember_payment_4(user)
    @user = user
    mail to: user.email, subject: "EFEJ 2017 - Não esqueça do pagamento"
  end

  def remember_payment_5(user)
    @user = user
    mail to: user.email, subject: "EFEJ 2017 - Não esqueça do pagamento!"
  end

  def calma_navegantes(user)
    @user = user
    mail to: user.email, subject: "EFEJ 2017 - Calma, navegantes!"
  end
end
