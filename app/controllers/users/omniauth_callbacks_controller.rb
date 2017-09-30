class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  #CALLBACK
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user[:status] == 'email_associate'
      flash[:notice] = "O email do seu facebook já está associada a uma conta."
      redirect_to authenticated_user_root_path
    else
      sign_in_and_redirect @user[:data], event: :authentication
    end
  end

  def failure
    flash[:notice] = "Aconteceu um erro inesperado! Entre em contato com a nossa equipe."
    redirect_to authenticated_user_root_path
  end


end
