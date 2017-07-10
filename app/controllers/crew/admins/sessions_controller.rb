class Crew::Admins::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]
  layout 'login_admin'
  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  protected
  #The path used after sign up.
  def after_sign_in_path_for(admin)
    crew_authenticated_admin_root_path
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.for(:sign_in) << :attribute
  end
end
