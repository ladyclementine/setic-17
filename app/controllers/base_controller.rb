class BaseController < ApplicationController
  layout "dashboard"
  before_action :authenticate_user!
  #before_action :check_terms

  private
  def check_terms
    if !current_user.terms_accept
      flash[:notice] = "Leia e aceite os termos de compromisso para ter acesso ao sistema."
      redirect_to terms_path
    end
  end
end
