class Crew::AdminsController < Crew::BaseController
  before_action :load_admin, only: [:edit, :update, :destroy]

  def dashboard
    @user = User.all
    @user_list = User.order("created_at DESC").limit(8)
    @eligible_users = User.eligible.order(:created_at)
    @disqualified_users = User.disqualified
    @allocated_users = User.allocated
    @pays = User.pays
    @onlines = User.online
    @lots = Lot.all.order("number")
    @select_boleto = User.joins(:payment).where("payments.method = 'Boleto'")
    @select_pagseguro = User.joins(:payment).where("payments.method = 'PagSeguro'")

    @total = 0
    @tPagseguro = 0
    @tBoleto = 0

    @pays.each do |user|
      if user.payment.method == 'PagSeguro' && user.payment.paid? && !user.payment.price.nil?
        @total += user.payment.price
        @tPagseguro += user.payment.price
      elsif user.payment.method == 'Boleto' && !user.payment.asaas_payments.nil? && !user.payment.price.nil?
        parcelas = user.payment.portions
        total_pago = user.payment.asaas_payments.where(status: 'RECEIVED').count
        @total += (user.payment.price/parcelas) * total_pago
        @tBoleto += (user.payment.price/parcelas) * total_pago
      end
    end
  end


  def info
  end

  def index
    @admins = Admin.all
  end

  def new
    @admins = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      redirect_to crew_admins_path, notice: "Admin criado com sucesso."
    else
      redirect_to crew_admins_path, alert: "Falha ao cadastrar novo admin."
    end
  end

  def update
    if @admin.update(admin_params)
      redirect_to  crew_admins_path, notice: 'Atualizado com sucesso'
    else
      redirect_to  crew_admins_path, notice: 'Erro'
    end
  end

  def destroy
    name = @admin.name
    if @admin.destroy
      redirect_to crew_admins_path, notice: "O administrador #{name} foi excluído."
    else
      redirect_to crew_admins_path, notice: "Não foi possível excluir o administrador #{name}."
    end
  end

  private
  def admin_params
    params[:confirmed_at] = Time.now
    params[:confirmation_sent_at] = Time.now
    params.require(:admin).permit(:name, :email, :password,
                                  :password_confirmation, :confirmed_at,
                                  :confirmation_sent_at)
  end

  def load_admin
    @admin = Admin.find(params[:id])
  end


end
