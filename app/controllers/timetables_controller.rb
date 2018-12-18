class TimetablesController < ApplicationController
  before_action :set_timetable, only: [:show, :edit, :update, :destroy]
  before_action 'check_access', only: [:index, :show, :new, :edit, :destroy, :class_states, :teachers_states, :plan, :available_teachers]

  # GET /timetables
  # GET /timetables.json
  def index
    @current_season_id = session[:active_season_id]
    @current_season = Season.find_by_id(session[:active_season_id])

    @current_season_group_ids = Group.where(:season_id => @current_season_id).select(:id)
    @timetables = Timetable.where(:group_id => @current_season_group_ids)

    #@tmp_array_of_group_ids = Array.new(Group.where(:season_id => session[:active_season_id]).select(:id).each{|gr| gr.id })

    #@id_array = []
    #@tmp_array_of_group_ids.each{|a| @id_array.push(a.group_id)}

    #@timetables = Timetable.where(:group_id => @id_array)


  end

  # GET /timetables
  # GET /timetables.json
  def class_states
    @current_season_id = session[:active_season_id]
    @current_season = Season.find_by_id(session[:active_season_id])

    @current_season_groups = Group.where(:season_id => @current_season_id, :isClosed => false)
    @current_season_morning_groups = @current_season_groups.where(:lesson_time_id => LessonTime.where(:lessonTimeTitle => "Irden").first.id)
    @current_season_noon_groups = @current_season_groups.where(:lesson_time_id => LessonTime.where(:lessonTimeTitle => "Günortan").first.id)
    @current_season_afternoon_groups = @current_season_groups.where(:lesson_time_id => LessonTime.where(:lessonTimeTitle => "Öýlän").first.id)
    @current_season_evening_groups = @current_season_groups.where(:lesson_time_id => LessonTime.where(:lessonTimeTitle => "Agşam").first.id)

    @current_season_morning_groups_ids = []
    @current_season_noon_groups_ids = []
    @current_season_afternoon_groups_ids = []
    @current_season_evening_groups_ids = []

    @current_season_morning_groups.each{|g| @current_season_morning_groups_ids.push(g.id)}
    @current_season_noon_groups.each{|g| @current_season_noon_groups_ids.push(g.id)}
    @current_season_afternoon_groups.each{|g| @current_season_afternoon_groups_ids.push(g.id)}
    @current_season_evening_groups.each{|g| @current_season_evening_groups_ids.push(g.id)}

    @rooms = Room.all.order(:roomFullTitle)
  end

  # GET /timetables
  # GET /timetables.json
  def teachers_states
    @current_season_id = session[:active_season_id]
    @current_season = Season.find_by_id(session[:active_season_id])

    @current_season_groups = Group.where(:season_id => @current_season_id, :isClosed => false)
    @current_season_morning_groups = @current_season_groups.where(:lesson_time_id => LessonTime.where(:lessonTimeTitle => "Irden").first.id)
    @current_season_noon_groups = @current_season_groups.where(:lesson_time_id => LessonTime.where(:lessonTimeTitle => "Günortan").first.id)
    @current_season_afternoon_groups = @current_season_groups.where(:lesson_time_id => LessonTime.where(:lessonTimeTitle => "Öýlän").first.id)
    @current_season_evening_groups = @current_season_groups.where(:lesson_time_id => LessonTime.where(:lessonTimeTitle => "Agşam").first.id)

    @current_season_morning_groups_ids = []
    @current_season_noon_groups_ids = []
    @current_season_afternoon_groups_ids = []
    @current_season_evening_groups_ids = []

    @current_season_morning_groups.each{|g| @current_season_morning_groups_ids.push(g.id)}
    @current_season_noon_groups.each{|g| @current_season_noon_groups_ids.push(g.id)}
    @current_season_afternoon_groups.each{|g| @current_season_afternoon_groups_ids.push(g.id)}
    @current_season_evening_groups.each{|g| @current_season_evening_groups_ids.push(g.id)}

    @rooms = Room.all.order(:roomFullTitle)
  end


  # GET /timetables
  # GET /timetables.json
  def available_teachers
    @current_season_id = session[:active_season_id]
    @this_season_groups = Group.where(:season_id => @current_season_id, :isClosed => false)
    @this_season_timetables = Timetable.where(:group_id => @this_season_groups.select(:id))
    @this_season_teachers = Teacher.where(:id => @this_season_groups.select(:teacher_id))
    @lesson_times = LessonTime.order(:lessonTimeFrom)
    @subject_categories = SubjectCategory.all

    if ((params[:subject_category_id].to_i != 0) || (params[:day_id].to_i != 0) || (params[:lesson_time_id].to_i != 0))

      @day = params[:day_id].to_i
      @lesson_time = params[:lesson_time_id].to_i
      @subject_category = params[:subject_category_id].to_i

      @specific_time_groups_ids = @this_season_groups.where(:lesson_time_id => params[:lesson_time_id].to_i).select(:id)  # ids of groups coinciding with selected lesson time

      if (params[:lesson_time_id].to_i != 0)
        @specific_time_groups_ids = @this_season_groups.where(:lesson_time_id => params[:lesson_time_id].to_i).select(:id)  # ids of groups coinciding with selected lesson time
      else
        @specific_time_groups_ids = @this_season_groups.select(:id)
      end

      if (params[:day_id].to_i != 0)
        @specific_day_groups_ids = @this_season_timetables.where(:weekday => params[:day_id].to_i).select(:group_id)  # ids of groups coinciding with selected weekday
      else
        @specific_day_groups_ids = @this_season_timetables.select(:group_id)
      end

      if (params[:subject_category_id].to_i != 0)
        @specific_subject_groups_ids = @this_season_groups.where(:subject_id => Subject.where(:subject_category_id => params[:subject_category_id].to_i).select(:id)).select(:id)  # ids of groups coinciding with selected weekday
      else
        @specific_subject_groups_ids = @this_season_groups.select(:id)
      end


      @unavailable_groups = @this_season_groups.where(:id => @specific_day_groups_ids)  # shol gunde dersi bolan toparlar
      @unavailable_groups = @unavailable_groups.where(:id => @specific_time_groups_ids) # shol wagtda dersi bolan toparlar


      @unavailable_teachers_ids = @unavailable_groups.select(:teacher_id)   # awtomatiki yagdayda girip bilmeyan mugallymlar.

      @available_groups = @this_season_groups.where.not(:id => @unavailable_groups.select(:id))
      @available_groups = @available_groups.where(:id => @specific_subject_groups_ids)

      @available_teachers = @this_season_teachers.where(:id => @available_groups.select(:teacher_id))
      @available_teachers = @available_teachers.where.not(:id => @unavailable_teachers_ids).order(:teacherFName)

    else
      @day_selected = 0
      @id_list = []
      @available_teachers = Teacher.where(:id => @id_list)
      @available_groups = Group.where(:id => @id_list)
    end

  end
  # GET /timetables/1
  # GET /timetables/1.json
  def show
  end

  # GET /timetables/new
  def new
    @timetable = Timetable.new
    @groups= Group.where(:season_id => session[:active_season_id]).order(:groupTitle)
    @rooms = Room.all.order(:roomFullTitle)
    @timetable.group_id = params[:group_id]                                                                          # Set this new timetable group the one with pressed id
  end

  # GET /timetables/1/edit
  def edit
    @groups= Group.where(:season_id => session[:active_season_id]).order(:groupTitle)
    @rooms = Room.all.order(:roomFullTitle)
  end

  def plan
    @timetables = Timetable.all
    #@current_season = Season.maximum("id")
    #@current_season_id = Season.where(:seasonNo=> Setting.where(:settingName => 'Aktiw_tapgyr')[0].settingValue)[0].id
    @current_season_id = session[:active_season_id]
    @current_groups = Group.where(:season_id => @current_season_id).order(:lesson_time_id)
    #@temp_groups = Group.where(:season_id => @current_season[0])
    #@current_groups = Group.where(:season_id => @current_season[0]).order(:lessonTime_id)
    #@current_groups = Group.all.order(:lessonTime_id)

    #@current_groups = @temp_groups
  end

  # POST /timetables
  # POST /timetables.json
  def create
    @timetable = Timetable.new(timetable_params)

    respond_to do |format|
      if @timetable.save
        Season.flush_season_timetables_cache

        format.html { redirect_to @timetable, notice: 'Timetable was successfully created.' }
        format.json { render :show, status: :created, location: @timetable }
      else
        format.html { render :new }
        format.json { render json: @timetable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /timetables/1
  # PATCH/PUT /timetables/1.json
  def update
    respond_to do |format|
      if @timetable.update(timetable_params)
        Season.flush_season_timetables_cache

        format.html { redirect_to @timetable, notice: 'Timetable was successfully updated.' }
        format.json { render :show, status: :ok, location: @timetable }
      else
        format.html { render :edit }
        format.json { render json: @timetable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /timetables/1
  # DELETE /timetables/1.json
  def destroy
    @timetable.destroy
    respond_to do |format|
      format.html { redirect_to timetables_url, notice: 'Timetable was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_timetable
      @timetable = Timetable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def timetable_params
      params.require(:timetable).permit(:group_id, :room_id, :weekday, :notes)
    end
end
