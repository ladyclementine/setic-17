class Crew::SchedulesController < Crew::BaseController
  before_action :set_event
  before_action :set_schedule, only: [:edit, :update, :destroy]
  # GET /events
  def index
    @event_schedules = @event.schedules
  end

  # GET /events/new
  def new
    @schedule = @event.schedules.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  def create
    @schedule = @event.schedules.new(schedule_params)
    respond_to do |format|
      if @schedule.save
        format.html { redirect_to [:crew, @event], notice: 'Horário da programação criado com sucesso.' }
        format.json { render :show, status: :created, location: @crew_event }
      else
        format.html { render :new }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  def update
    if @schedule.update(schedule_params)
      redirect_to [:crew, @event], notice: 'Horário da programação editado com sucesso.'
    else
      render :edit
    end
  end

  # DELETE /events/1
  def destroy
    @schedule.destroy
    redirect_to [:crew, @event], notice: 'Horário da programação deletado com sucesso.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:event_id])
    end

    def set_schedule
      @schedule = @event.schedules.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def schedule_params
      params.require(:schedule).permit(:start_time, :end_time)
    end
end
