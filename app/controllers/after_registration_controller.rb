class AfterRegistrationController < BaseController
  before_action :get_user
  before_action :verify_register_conclusion, :except=>[:update]

  def edit
  end

  def update
    @user.completed = true
    respond_to do |format|
      if @user.update_attributes(user_params)
        flash[:success] = "Cadastro completo, realize o pagamento para garantir sua vaga."
        #Event.where(is_shirt:true).each do |event|
           #event.add current_user
         #end
        format.html {  redirect_to authenticated_user_root_path }
      else
        #flash[:error] = "Não foi possível completar seu cadastro, verifique se seus dados estão corretos e entre em contato com nossa equipe."
        format.html { render 'edit'}
        format.json {  render json: @user.errors }
      end
    end
  end


  private

  def verify_register_conclusion
    if @user.is_completed?
      redirect_to authenticated_user_root_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :general_register, :birthday ,:cpf, :course, :semester, :university, :shirt, :registration, :entry_year)
  end

  def user_email_params
    params.require(:user).permit(:email)
  end
end
