class TermsController < ApplicationController
  before_action :get_user
  before_action :authenticate_user!
  layout "terms"
  def index
  end

  def update
    if @user.update_attribute(:terms_accept, true)
      redirect_to authenticated_user_root_path
    else
      flash[:error] = "Erro! Contante nossa equipe."
      redirect_to authenticated_user_root_path
    end
  end
end
