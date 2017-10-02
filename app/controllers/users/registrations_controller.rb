class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  before_action :get_user
  before_action :check_open_system, only: [:new, :create]
  #before_action :verify_facebook_login, only: :edit_password
  layout :determine_layout
  # GET /resource/sign_up
  def new
    super
  end

  def create
    @user = User.new(inscription_params)
    @user.active = true
    set_minimum_password_length
    if @user.save
      flash[:success] = "Inscrição realizada, em instantes receberá as instruções de confirmação no seu e-mail."
      redirect_to reminder_path
    else
      flash[:error] = "Um erro ocorreu, não foi possível processar sua inscrição. #{@user.errors.full_messages}"
      redirect_to new_user_registration_path
    end
  end

  #Lembrar o usuario de confirmar sua conta
  def show_reminder
    render :layout => false
  end

  def update
    @user.completed = true
    @user.cpf = Cpf.new(params[:user][:cpf])
    respond_to do |format|
      if @user.save && @user.update_attributes(user_params)
        flash[:success] = "Cadastro atualizado."
        format.html {  redirect_to authenticated_user_root_path }
      else
        format.html { render 'edit'}
        format.json {  render json: @user.errors }
      end
    end
  end

  def edit_password

  end


  def update_password
    if @user.valid_password?(params[:user][:current_password])
      if @user.update(password_params)
        # Sign in the user by passing validation in case their password changed
        sign_in @user, :bypass => true
        flash[:sucsses] = "Senha alterada com sucesso."
        redirect_to authenticated_user_root_path
      else
        flash[:error] = "Não foi possível alterar sua senha."
        redirect_to password_edit_path
      end
    else
      flash[:error] = "Senha atual incorreta."
      redirect_to password_edit_path
    end
  end


  protected
  #If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end


  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  end

  private

  #PARAMETROS PARA A INSCRIÇÃO INICIAL
  def inscription_params
    params.require(:user).permit(:email,:password, :password_confirmation)
  end

  def user_params
    # NOTE: Using `strong_parameters` gem
    params.require(:user).permit(:name, :general_register, :birthday ,:cpf, :gender, :avatar, :phone, :university, :shirt)
  end

  def password_params
    # NOTE: Using `strong_parameters` gem
    params.require(:user).permit(:password, :password_confirmation)
  end

  def verify_facebook_login
    unless User.find(@user.id).uid.nil?
      flash[:notice] = "Contas associadas ao facebook não podem alterar uma senha :)"
      redirect_to new_user_session_path
    end
  end


  def check_open_system
    @config = Config.first
    unless @config.nil?
      if @config.close
        flash[:notice] = "Aguarde a abertura do próximo lote para realizar seu cadastro. Para mais informações, visite nossa página no Facebook."
        redirect_to authenticated_user_root_path
      end
    end
  end
end
