class UserDashboardController < BaseController
  before_action :get_user
  before_action :verify_register_conclusion, :except=>[:about]

  def index
    @days = Event.join_events_by_time
    @payment = @user.payment
    if !@payment.nil?
      case @user.payment.method
      when "PagSeguro"
        @method_message = "entrar novamente no PagSeguro."
      when "Boleto"
        @method_message = "receber um novo email com os boletos"
        @billets_links = AsaasPayment.where(custumer_id: @payment.user_asaas_id).order("description")
      when "Dinheiro"
        @method_message = "rever os dados da conta"
      end
    end

    if @user.federation_check=='Sim'
      @federado = 'FEDERADA'
    elsif @user.federation_check=='Não'
      @federado = 'NÃO FEDERADA'
    else
      @federado = @user.federation_check.mb_chars.upcase
    end


    #top 5
    @ej = User.all.where.not(junior_enterprise:nil).order(:junior_enterprise).group_by{|d| d.junior_enterprise.split(' ').first.downcase}.sort_by { |k, v| v.count }.reverse.take(5)

  end

  def about
  end

  def active_account
    if !@user.active
      @lot = Lot.active_lot
      if !@lot.nil? && !@lot.is_full? && @user.lot.nil?
        @user.lot = @lot
      end
      @user.active = true
      @user.created_at = Time.now
      @user.save!
      redirect_to authenticated_user_root_path
    end
  end

end
