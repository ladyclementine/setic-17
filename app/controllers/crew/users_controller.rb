class Crew::UsersController < Crew::BaseController
  before_action :load_user, only: [:edit, :update, :disqualify, :requalify, :certificate_update]

  def index
    #respond_to do |format|
    #  format.html
    #  format.json { render json: UserDatatable.new(view_context) }
    #end
    respond_to do |format|
      format.html
      format.json { render json: UserDatatable.new(view_context, {table_select: 'all'}) }
    end
  end

  def edit
    @payment = @user.payment
    @lots = Lot.all
    @user_lot = @user.lot unless @user.lot.nil?
  end

  def update
    @user.update_attribute(:password, params[:user][:password]) unless params[:user][:password] == ""
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to edit_crew_user_path(@user), notice: "Usuário atualizado com sucesso." }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def qualified
    respond_to do |format|
      format.html
      format.json { render json: UserDatatable.new(view_context, {table_select: 'qualified'}) }
    end
  end

  def qualified_server
  end

  def waiting_list
    @users = User.eligible
    @list = true

    @lot = Lot.active_lot
    if !@lot.nil? && !@lot.is_full?
      @lot_active = @lot
    else
      flash[:notice] = "Não há lotes abertos. Crie ou edite um lote."
    end
  end

  def disqualified
    @users = User.disqualified
  end

  def pays_list
    respond_to do |format|
      format.html
      format.json { render json: UserDatatable.new(view_context, {table_select: 'pay'}) }
    end
  end

  def ejs_list
    #patrickeeeeeeeeee
    @ej = User.all.where.not(junior_enterprise:nil).order(:junior_enterprise).group_by{|d| d.junior_enterprise.split(' ').first.downcase}
    #@ej.each do |ej|
    # split_part = postgre   substring_index = mysql
    @users = User.where("lower(split_part(junior_enterprise, ' ', 1)) = ?", "#{params[:ej]}")
    @users_l = params[:ej].nil? ? User.allocated : @users
    #junior_enterprise group('name AS grouped_name, age')
  end

  def ejs_chat
    @ej = User.all.where.not(junior_enterprise:nil).order(:junior_enterprise).group_by{|d| d.junior_enterprise.split(' ').first.downcase}.sort_by { |k, v| v.count }.reverse
  end


  def certificate
    @users = User.pays_total
  end

  def certificate_update
    if @user.update_attributes(:certificate => params[:value])
      if params[:value] == "SIM"
        render :status => 200, :json => {infos: "Certificado liberado. E-mail enviado para o congressista."}
        #UsersLotMailer.certificate(@user).deliver_now
      else
        render :status => 200, :json => {infos: "Certificado bloqueado."}
      end
    else
      render :status => 421, :json => {infos: "Erro não identificado"}
    end
  end

  private
  def load_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email,:name, :general_register, :birthday ,:cpf, :gender, :avatar, :phone, :special_needs, :federation, :junior_enterprise, :job, :university, :transport_required,:transport_local, :cep, :state, :city, :address, :name_parents, :phone_parents, :federation_check)
  end
end
