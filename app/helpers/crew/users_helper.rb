module Crew::UsersHelper
  def count_paymeny_ej(usuarios)
    usuarios.select{ |user| !user.payment.nil? && user.payment.portion_paid > 0}.count
  end

  def count_alocados(usuarios)
    usuarios.select { |user| user.lot_id.is_a? Integer }.count
  end

  def count_fila(usuarios)
    usuarios.select { |user| user.active == true && user.completed == true && user.lot_id == nil }.count
  end

  def count_pagototal(usuarios)
    usuarios.select{ |user| !user.payment.nil? && user.payment.portions == user.payment.portion_paid }.count
  end

  def count_pagoparcial(usuarios)
    usuarios.select{ |user| !user.payment.nil? && user.payment.portion_paid > 0 && user.payment.portion_paid != user.payment.portions }.count
  end

  #DATATABLE
  def payment_view(payment)
    if payment.nil?
      'Não Selecionado'
    elsif payment.method == "PagSeguro"
      if payment.paid?
        content_tag(:small, "PagSeguro", class: "label bg-green", 'data-toggle': 'tooltip', title: '', 'data-original-title': "Pagamento Recebido")
      else
        content_tag(:small, "PagSeguro", class: "label bg-red", 'data-toggle': 'tooltip', title: '', 'data-original-title': "Pagamento #{payment.status_pagseguro.nil? ? ' Pendente' : payment.status_pagseguro}")
      end
    else  
      if payment.paid?
        content_tag(:small, payment.method, class: "label bg-green", 'data-toggle': 'tooltip', title: '', 'data-original-title': "Pagamento Recebido")
      else
        content_tag(:small, payment.method, class: "label bg-red", 'data-toggle': 'tooltip', title: '', 'data-original-title': "Pagamento Pendente")
      end
    end
  end

  def payment_view_pdf(payment)
    if payment.nil?
      'Não selecionado'
    else
      if payment.paid?
        "#{payment.method} - "
      else
        "#{payment.method} - Não Pago"
      end
    end
  end

  def lot_name(lot)
    lot.nil? ? 'Não Alocado' : "Lote #{lot.number}"
  end

  def ej_name(ej)
    ej.nil? ? 'Não Informado' : ej
  end

  def button_edit(user_id)
    link_to  edit_crew_user_path(user_id) do
      content_tag(:small, class: "btn btn-default dropdown-toggle btn-xs") do
        content_tag(:i, "", class: "fa fa-pencil-square-o") + "Editar"
      end
    end
  end

  def button_login(user_id)
    link_to  crew_login_user_path(user_id), target: "_blank", method: :patch do
      button_tag "Login", type: 'button', class: "btn btn-block btn-warning btn-sm"
    end
  end
end
