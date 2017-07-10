class Crew::ChangeVacanciesController < Crew::BaseController
  before_action :set_vendedor_and_comprador, only: [:processar]

  def index
    
  end

  def processar
    if !@vendedor.nil?
      if !@vendedor.payment.nil? && @vendedor.payment.partially_paid?
        comprador_existe?
      else
        render :status => 422, :json => {menssage: 'Vendedor não pagou nenhuma parcela.'}
      end
    else
      render :status => 422, :json => {menssage: 'Vendedor não existe no sistema.'}
    end
  end

  private
  def comprador_existe?
    if !@comprador.nil?
      if @comprador.is_completed?
        if !@comprador.payment.nil? && @comprador.payment.portion_paid != 0
          render :status => 422, :json => {menssage: 'Comprador não pode trocar a vaga. Pagou algo!'}
        else
          trocar_caso_exista
        end
      else
        render :status => 422, :json => {menssage: 'Comprador não finalizou o cadastro.'}
      end
    else
      trocar_caso_n_exista
    end
  end

  #Caso comprador exista
  def trocar_caso_exista
    @comprador.payment.destroy unless @comprador.payment.nil?

    @comprador.lot_id = @vendedor.lot_id
    @comprador.active = true

    @vendedor.lot_id = nil
    @vendedor.active = false

    @vendedor.save
    @comprador.save
    @vendedor.payment.update_attribute(:user_id, @comprador.id)
    @vendedor.payment.asaas_payments.update_all(user_id: @comprador.id) # VERIFICAR?
 
    render :status => 200, :json => {type: 'exist'}
  end

  def trocar_caso_n_exista
    #* completed do vendedor = false
    #* SETAR NIL ==> :name, :general_register, :birthday ,:cpf, :gender, :avatar, :phone, :special_needs, :federation, :junior_enterprise, :job, :university, :transport_required,:transport_local, :cep, :state, :city, :address, :name_parents, :phone_parents, :federation_check
    #* Atualizar email: email do comprador
    #* Atualizar senha PADRAO 'trocaecej99-100(random)'
    render :status => 422, :json => {menssage: 'Módulo para compradores não existes ainda Não foi feito =D'}
  end

  def set_vendedor_and_comprador
    #params[:email_vendedor] =    'a.andraderenan@gmail.com'
    #params[:email_comprador] =  'luccadesamoreira@gmail.com'
    @vendedor = User.where(email: params[:email_vendedor].gsub(' ','')).first
    @comprador = User.where(email: params[:email_comprador].gsub(' ','')).first
  end

end
