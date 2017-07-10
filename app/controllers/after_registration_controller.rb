class AfterRegistrationController < BaseController
  before_action :get_user
  before_action :verify_register_conclusion, :except=>[:update]
  before_action :set_bau
  before_action :verify_confirm_face, only: [:edit_email, :update_email]
  #before_action :dia_16

  def dia_16
    redirect_to about_path
  end

  def set_bau
    @dados = User.with_deleted.where("email = '#{current_user.email}' or uid = '#{current_user.uid}'").where.not(deleted_at: nil, completed:false).first
    #se encontrar a pessoa, atualiza algumas informações
    unless @dados.nil?
      @user.name = @dados.name
      @user.cpf = @dados.cpf
      @user.general_register = @dados.general_register
      @user.birthday = @dados.birthday
      @user.gender = @dados.gender
      @user.phone = @dados.phone
      @user.federation = @dados.federation
      @user.junior_enterprise = @dados.junior_enterprise
      @user.job =  @dados.job
      @user.university = @dados.university
      @user.special_needs = @dados.special_needs
      @user.address = @dados.address
      @user.state = @dados.state
      @user.transport_required = @dados.transport_required
      @user.transport_local = @dados.transport_local
      @user.city = @dados.city
      @user.cep = @dados.cep
      @user.phone_parents = @dados.phone_parents
      @user.name_parents   = @dados.name_parents
      @user.federation_check = @dados.federation_check
      @user.avatar = @dados.avatar
    end
  end

  def edit
  end

  def edit_email

  end

  def update_email
    respond_to do |format|
      if @user.update_attributes(user_email_params)
        @user.update_attributes(unconfirmed_email: user_email_params[:email]) unless @user.errors.any?
        if @user.email == user_email_params[:email]
          @user.send_confirmation_instructions unless @user.errors.any?
        end
        flash[:success] = "Aguardando confirmação."
        format.html { redirect_to email_completar_path }
      else
        format.html { render 'edit_email'}
        format.json { render json: @user.errors }
      end
    end
  end

  def update
    @user.completed = true
    #se uma pessoa q tiver cadastrado no dia 6 vier a terminar o cadastro no dia 15, ela n ganha prioridade
    @user.created_at = Time.now
    #buscar lot aberto
    @lot = Lot.active_lot
    if !@lot.nil? && !@lot.is_full? && @user.lot.nil?
      @user.lot = @lot
    end
    respond_to do |format|
      if @user.update_attributes(user_params)
        UsersLotMailer.not_allocated(@user).deliver_now if @user.lot.nil?
        #apagar conta anterior
        unless @dados.nil?
          @dados.payment.asaas_payments.destroy_all if !@dados.payment.nil? && @dados.payment.method=='Boleto'
          @dados.payment.destroy unless @dados.payment.nil?
          @dados.really_destroy!
        end
        flash[:success] = "Cadastro completo, realize o pagamento para garantir sua vaga."
        format.html {  redirect_to authenticated_user_root_path }
      else
        #flash[:error] = "Não foi possível completar seu cadastro, verifique se seus dados estão corretos e entre em contato com nossa equipe."
        format.html { render 'edit'}
        format.json {  render json: @user.errors }
      end
    end
  end

  #format.html { render :new }
  #   format.json { render json: @subcategories.errors, status: :unprocessable_entity }

  private

  def verify_register_conclusion
    if @user.is_completed?
      redirect_to authenticated_user_root_path
    end
  end

  def verify_confirm_face
    if @user.face_confirmed?
      redirect_to authenticated_user_root_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :general_register, :birthday ,:cpf, :gender, :avatar, :phone, :special_needs, :federation, :junior_enterprise, :job, :university, :transport_required,:transport_local, :cep, :state, :city, :address, :name_parents, :phone_parents, :federation_check)
  end

  def user_email_params
    params.require(:user).permit(:email)
  end
end
