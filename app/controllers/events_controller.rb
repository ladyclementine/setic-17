class EventsController < BaseController
  before_action :get_user
  before_action :verify_register_conclusion
  #before_action :if_event_close_redirect

  #before_action :close_insert_exit_event, only: [:enter_event,:exit_event]


  def index
   # @days = Event.join_events_by_time
   @days = Event.join_events_by_time
  end

  def enter_event
    event = Event.find(params[:id])
    if event.nil?
      render :status => 200, :json => {mensage: "not_found"}
    elsif event.full?
      render :status => 200, :json => {mensage: "full", subscribers: event.users.count, infos: "A programação chegou na sua capacidade máxima."}
    elsif current_user.has_concurrent_event?(event)
      concurrents_names = event.concurrents(current_user).map { |event| event.name }.join(' | ')
      render :status => 200, :json => {mensage: "conflict", subscribers: event.users.count, infos: "Você possui outra(s) programação(ões) no mesmo horário! - #{concurrents_names}"}
    else
      event.add current_user
      if event.contains? current_user
        render :status => 200, :json => {mensage: "success", subscribers: event.users.count, infos: "Você garantiu sua vaga no(a) #{event.name}!"}
      else
        render :status => 500, :json => {mensage: "error", subscribers: event.users.count, infos: "Não foi possível garantir sua vaga no(a) #{event.name}. Tente novamente"}
      end
    end

  end


  def exit_event
    event = Event.find(params[:id])
    event.remove current_user

    if event.contains? current_user
      render :status => 200, :json => {mensage: "error", infos: "Não foi possível sair da programação.",  subscribers: event.users.count}
    else
      render :status => 200, :json => {mensage: "success", infos: "Você saiu da programação.",  subscribers: event.users.count}
    end
  end
end
