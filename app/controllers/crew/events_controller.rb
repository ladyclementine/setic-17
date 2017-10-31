class Crew::EventsController < Crew::BaseController
  before_action :set_crew_event, only: [:show, :edit, :update, :destroy, :remove_user_all]

  # GET /crew/events
  # GET /crew/events.json
  def index
    @crew_events = Event.where(is_shirt: false)
  end

  # GET /crew/events/1
  # GET /crew/events/1.json
  def show
    @users_nopays = @crew_event.users.no_pays_or_no_select
    @users_pays = @crew_event.users.pays
  end

  def pending
    @days = Event.join_events_by_time
  end


  # GET /crew/events/new
  def new
    @crew_event = Event.new
  end

  # GET /crew/events/1/edit
  def edit
  end

  # POST /crew/events
  # POST /crew/events.json
  def create
    @crew_event = Event.new(crew_event_params)

    respond_to do |format|
      if @crew_event.save
        format.html { redirect_to crew_events_path, notice: 'Evento foi criado com sucesso.' }
        format.json { render :show, status: :created, location: @crew_event }
      else
        format.html { render :new }
        format.json { render json: @crew_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /crew/events/1
  # PATCH/PUT /crew/events/1.json
  def update
    respond_to do |format|
      if @crew_event.update(crew_event_params)
        format.html { redirect_to crew_events_path, notice: 'Evento foi atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @crew_event }
      else
        format.html { render :edit }
        format.json { render json: @crew_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /crew/events/1
  # DELETE /crew/events/1.json
  def destroy
    @crew_event.users.destroy_all
    @crew_event.destroy
    respond_to do |format|
      format.html { redirect_to crew_events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def remove_user
    user  = User.find(params[:user_id])
    event = Event.find(params[:id])
    event.remove(user)
    flash[:success] = "#{user.email} foi removido de #{event.name}."
    redirect_to :back
  end

  def remove_user_all
    @users_nopays = @crew_event.users.no_pays_or_no_select
    @crew_event.remove(@users_nopays)
    flash[:success] = "Todos os usuários não pagantes foram removidos de #{@crew_event.name}."
    redirect_to :back
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_crew_event
    @crew_event = Event.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def crew_event_params
    params.require(:event).permit(:name, :start, :end, :limit, :description, :facilitator, :avatar, :event_type_id, :price)
  end
end
