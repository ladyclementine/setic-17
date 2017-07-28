class Crew::LotsController < Crew::BaseController
  before_action :load_lot, only: [:show, :edit, :update, :destroy]

  def index
    @lots = Lot.all
  end

  def edit
  end

  def show
    @users = @lot.users
  end

  def new
    @lot = Lot.new
  end

  def create
    @lot = Lot.new(lot_params)
    respond_to do |format|
      if @lot.save
        flash[:success] = "Lote criado com sucesso."
        format.html {  redirect_to crew_lots_path }
      else
        format.html { render :new }
        format.json { render json: @lot.errors}
      end
    end
  end

  def update
    respond_to do |format|
      if @lot.update(lot_params)
        flash[:success] = "Lote editado com sucesso."
        format.html {  redirect_to crew_lots_path }
      else
        format.html { render 'edit'}
        format.json { render json: @lot.errors }
      end
    end
  end


  private

  def load_lot
    @lot = Lot.find(params[:id])
  end

  def lot_params
    params.require(:lot).permit(:name, :number, :limit, :value_federated,
                                :value_not_federated, :start_date, :end_date, :nohost_active, :value_federated_nohost, :value_not_federated_nohost)
  end
end
