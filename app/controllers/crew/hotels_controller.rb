class Crew::HotelsController < Crew::BaseController
  before_action :set_hotel, only: [:edit, :update]

  def index
    @hotels = Hotel.all.order(:id)
  end

  def edit

  end

  def users
    @hotel = Hotel.find(params[:hotel_id])
  end

  def update
    if @hotel.update(hotel_params)
      redirect_to crew_hotels_path, notice: "Hotel editado com sucesso."
    else
      redirect_to edit_crew_hotel_path(@hotel), alert: "Não foi possível alterar hotel."
    end
  end

  private

  def set_hotel
    @hotel = Hotel.find(params[:id])
  end

  def hotel_params
    params.require(:hotel).permit(:name, :extra_info)
  end
end
