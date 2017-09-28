class KitController < BaseController
  before_action :get_user
  def select
    kit = Event.find(params[:id])
    if kit.nil?
      redirect_to kits_path, notice: "Kit não Existe"
    elsif kit.full?
      redirect_to kits_path, notice: "ESGOTADO!"
    else
      kit.add current_user
      if kit.contains? current_user
         redirect_to kits_path, notice: "Selecionado com sucesso"
      else
        redirect_to kits_path, notice: "Error ao selecionar"
      end
    end

  end

  def remove
  end

  def index
  	@kits = Event.where(is_shirt: true)
  end
end
