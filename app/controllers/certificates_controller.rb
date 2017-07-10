class CertificatesController < BaseController
  before_action :check_forms
  before_action :close_certi

  def close_certi
    flash[:notice] = "Por enquanto, não estamos processando novos certificados."
    redirect_to authenticated_user_root_path
  end

  def show
    respond_to do |format|
      format.pdf do

        filedir = "tmp/PD#{current_user.id}F.pdf"

        pdf = Certificate.new(current_user, filedir).render
        send_data pdf, filename: "certificado_ecej_2017.pdf", type: "application/pdf", disposition: "inline"


        #current_user.certificate = File.open(filedir)
      end
    end
  end

  #verificar se a pessoa respondeu a pesquisa.
  def check_forms
    unless current_user.certificate=="SIM"
      flash[:notice] = "Ainda não verificamos se você respondeu a pesquisa. Se tiver respondido tente novamente mais tarde."
      redirect_to authenticated_user_root_path
    end
  end
end
