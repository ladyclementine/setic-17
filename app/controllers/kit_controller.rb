class KitController < BaseController
  before_action :get_user
  before_action :error_if_try_pay_has_select, only: [:select, :remove] # PENDENTE
  def select
    kit = Event.find(params[:id])
    if kit.nil?
      redirect_to kits_path, notice: "Kit não Existe"
    elsif kit.full?
      redirect_to kits_path, notice: "ESGOTADO!"
    else
      kit.add current_user
      if kit.contains? current_user
        p params
        p 1111111111
        redirect_to kits_path, notice: "Selecionado com sucesso"
      else
        redirect_to kits_path, notice: "Error ao selecionar"
      end
    end

  end

  def remove
    kit = Event.find(params[:id])
    kit.remove current_user

    if kit.contains? current_user
      redirect_to kits_path, notice: "Não foi possível remover o kit."
    else
      redirect_to kits_path, notice: "Você removeu o kit."
    end
  end

  def index
    @kits = Event.where(is_shirt: true)
  end

  private
  def error_if_try_pay_has_select
    payment = @user.payment
    if !payment.nil?
      redirect_to kits_path, notice: "Você não pode adicionar ou remover o kit depois que selecionar o pagamento."
    end
  end
end
