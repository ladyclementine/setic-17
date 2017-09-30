class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  include ApplicationHelper
  before_action :manu
  before_action :user_activity
  before_action :prepare_exception_notifier
  #before_action :room_open?
  #before_action :event_open?
  #before_action :authenticate
  before_action :load_config
  protected
  def load_config
    @config = Config.first
  end
  
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "gtigti" && password == "gti2gti"
    end
  end

  def room_open?
    day_open = DateTime.new(2017, 12, 30, 21, 59, 50 , '-3')
    now = DateTime.now
    @room_open = (day_open>=now ? false : true)

    unless get_admin.nil?
      @room_open = true unless @room_open
    end
  end

  def if_room_close_redirect
    unless @room_open
      flash[:error] = "Modulo não disponível no momento."
      redirect_to authenticated_user_root_path
    end
  end

  def event_open?
    day_open = DateTime.new(2017, 12, 30, 21, 59, 50 , '-3')
    now = DateTime.now
    @event_open = (day_open>=now ? false : true)

    unless get_admin.nil?
      @event_open = true unless @event_open
    end
  end

  def if_event_close_redirect
    unless @event_open
      flash[:error] = "Modulo não disponível no momento."
      redirect_to authenticated_user_root_path
    end
  end

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :user
      new_user_session_path
    elsif resource_or_scope == :crew_admin
      new_crew_admin_session_path
    else
      new_user_session_path
    end
  end

  def authenticate_admin!
    if admin_signed_in?
      super
    else
      redirect_to new_crew_admin_session_path
      ## if you want render 404 page
      ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end

  end

  #manutençaõ by patrick
  #comandos
  #heroku config:set MAINTENANCE_MODE=enabled  e  heroku config:unset MAINTENANCE_MODE
  #heroku config:set MAINTAINER_IPS=187.79.84.147,177.19.85.189

  def manu
    if maintenance_mode_enabled? && get_admin.nil?
      if !folder_open?
        render :file => 'public/maintenance.html', :status => 200, :layout => false
      end
    end
  end

  def folder_open?
    folders_list?.split(',').each do |i|
      request.fullpath.split('/').each do |j|
        if i==j
          return true
        end
      end
    end
    return false
  end

  def maintenance_mode_enabled?
    #ENV['MAINTENANCE_MODE']
    dia20 = DateTime.new(2017, 04, 18, 21, 59, 50 , '-3')
    now = DateTime.now
    dia20>=now ? true : false
  end

  #acesso para todos (admin)
  def folders_list?
    'crew,confirm_payment_asaas,confirm_payment'
  end

  #def maintainer_ips
  #  ENV['MAINTAINER_IPS'] || String.new
  #end

  #def remote_address_whitelisted?
  # maintainer_ips.split(',').include?(request.remote_ip)
  #end

  def verify_register_conclusion
    if !@user.is_completed?
      flash[:notice] = "Conclua sua inscrição para acessar todas as funções do sistema"
      #flash[:notice] = "Não é possível finalizar seu cadastro. Aguarde até o dia 20 para se inscrever novamente!"
      redirect_to cadastro_completar_path
      return false
    end
  end

  helper_method :check_and_redirect


  def determine_layout
    current_user.nil? ? "login" : "dashboard"
  end

  def get_current_lot
    @current_lot = Lot.active_lot
  end


  def get_user
    @user ||= current_user
  end

  def get_admin
    @admin ||= current_crew_admin
  end

  def user_activity
    current_user.try :touch
  end

  def prepare_exception_notifier
  end

  def user_must_have_paid
    if current_user.payment.nil? || !current_user.payment.paid?
      flash[:notice] =  "Por favor, efetue o pagamento."
      redirect_to authenticated_user_root_path
    end
  end

  def verify_user_lot
    if @user.lot.nil?
      flash[:notice] = "Por enquanto, não temos vagas, aguarde a abertura de novas vagas."
      redirect_to authenticated_user_root_path
    end
  end

end
