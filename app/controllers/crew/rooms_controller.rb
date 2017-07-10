class Crew::RoomsController < Crew::BaseController
  before_action :set_room, only: [:edit, :update, :destroy, :show]

  def index
    @rooms = Room.all
  end

  def show
    @users = @room.users
  end

  def edit
  end

  def update
    respond_to do |format|
      if @room.update(room_params)
        flash[:success] = "Quarto editado com sucesso."
        format.html {  redirect_to crew_rooms_path }
      else
        format.html { render 'edit'}
        format.json { render json: @room.errors }
      end
    end
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    respond_to do |format|
      if @room.save
        format.html { redirect_to crew_rooms_path, notice: 'Quarto foi criado com sucesso.' }
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @room.users.update_all(room_id: nil)
    @room.destroy
    respond_to do |format|
      format.html { redirect_to crew_rooms_path }
      format.xml  { head :ok }
    end
  end

  private

  def set_room
    @room =  Room.find(params[:id])
  end


  def room_params
    params.require(:room).permit(:number, :extra_info, :capacity, :hotel_id,:air)
  end

end
