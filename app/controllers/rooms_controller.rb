class RoomsController < BaseController
  before_action :get_user
  before_action :verify_register_conclusion
  before_action :get_hotel, except: [:change_name]
  before_action :if_room_close_redirect
  before_action :user_must_have_paid

  #before_action :close_insert_exit_room, only: [:insert_current_user_into_room,:exit_room]

  def close_insert_exit_room
    if get_admin.nil?
      flash[:notice] = "Não é mais possivel entrar,trocar ou sair do quarto."
      redirect_to rooms_url(@hotel.id)
    end
  end

  def index
    @rooms = Room.includes(:users).where(hotel: @hotel).order(:number)
    Rails.cache.fetch(:@rooms, expires_in: 15.minutes) { @rooms }
  end

  def insert_current_user_into_room
    room = Room.find(params[:id])
    if room.full?
      redirect_to rooms_url(@hotel.id), alert: "Quarto está cheio. Tente outro."
    else
      current_user.update(room_id: room.id)
      redirect_to rooms_url(@hotel.id), notice: "Você está no quarto #{room.number} do hotel #{room.hotel.name}"
    end
  end

  def exit_room
    if current_user.room.nil?
      redirect_to rooms_url(@hotel.id), alert: "Você não está em quarto algum."
    elsif current_user.exit_room!
      redirect_to rooms_url(@hotel.id), notice: "Você saiu do quarto."
    else
      redirect_to rooms_url(@hotel.id), alert: "Não foi possível sair do quarto. Tente novamente."
    end
  end

  def change_name
    room = Room.find(params[:room_id])
    name_room = Array.new(3)
    name_room[0] = params[:name]
    name_room[1] = @user.two_names
    name_room[2] = @user.id

    if room.users.include? @user
      room.update_attribute(:name, name_room)
      render :status => 200, :json => {mensage: "success", user_add: @user.two_names}
    else
      render :status => 200, :json => {mensage: "error"}
    end
  end

  private
  def get_hotel
    @hotel = Hotel.find(params[:hotel_id])
  end

end
