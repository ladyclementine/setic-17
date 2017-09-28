class KitController < BaseController
  def select
    kit = Event.find(params[:id])
    if kit.nil?
      render :status => 200, :json => {mensage: "not_found"}
    elsif kit.full?
      render :status => 200, :json => {mensage: "full", subscribers: kit.users.count, infos: "A programação chegou na sua capacidade máxima."}
    else
      kit.add current_user
      if kit.contains? current_user
        
      else
        render :status => 500, :json => {mensage: "error", subscribers: kit.users.count, infos: "Não foi possível garantir sua vaga no(a) #{event.name}. Tente novamente"}
      end
    end

  end

  def remove
  end

  def index
  	@kits = Event.where(is_shirt: true)
  end
end
