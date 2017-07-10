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
    @lots = Lot.new
  end

  def create
    @lot = Lot.new(lot_params)
    if @lot.save
      redirect_to crew_lots_path, notice: "Lote criado com sucesso"
    else
      render :new
    end
  end

  def update
    if @lot.update(lot_params)
      redirect_to crew_lots_path, notice: "Lote editado com sucesso."
    else
      redirect_to edit_crew_lot_path(@lot), alert: "Não foi possível alterar lote."
    end
  end


  private

  def load_lot
    @lot = Lot.find(params[:id])
  end

  def lot_params
    params.require(:lot).permit(:name, :number, :limit, :value_federated,
                                :value_not_federated, :start_date, :end_date)
  end
end
