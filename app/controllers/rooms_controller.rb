class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  before_action 'check_access', only: [:index, :show, :new, :edit, :destroy]

  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.all
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    #@room_timetable = @room.timetables.all
    @this_season_groups = Group.where(:season_id => session[:active_season_id])

    @morning_groups = @this_season_groups.where(:lesson_time_id => LessonTime.find_by_lessonTimeTitle("Irden").id)
    @gunortan_groups = @this_season_groups.where(:lesson_time_id => LessonTime.find_by_lessonTimeTitle("Günortan").id)
    @afternoon_groups = @this_season_groups.where(:lesson_time_id => LessonTime.find_by_lessonTimeTitle("Öýlän").id)
    @evening_groups = @this_season_groups.where(:lesson_time_id => LessonTime.find_by_lessonTimeTitle("Agşam").id)

    @room_timetable = @room.timetables.where(:group_id => @this_season_groups.select(:id))

    @room_morning_timetable = @room_timetable.where(:group_id => @morning_groups.select(:id))
    @room_gunortan_timetable = @room_timetable.where(:group_id => @gunortan_groups.select(:id))
    @room_afternoon_timetable = @room_timetable.where(:group_id => @afternoon_groups.select(:id))
    @room_evening_timetable = @room_timetable.where(:group_id => @evening_groups.select(:id))
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        format.html { redirect_to @room, notice: 'Room was successfully created.' }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to @room, notice: 'Room was successfully updated.' }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: 'Room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:roomFullTitle, :roomShortTitle, :roomCapacity, :hasProjector, :hasEboard, :notes)
    end
end
