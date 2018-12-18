class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :info_list, :attendance_list, :attendance_report, :update, :destroy]
  before_action 'check_access', only: [:index, :show, :new, :edit, :destroy, :agaly_report, :info_list, :attendance_list, :attendance_report, :availability, :availability_granica, :information]

  @@current_group = ""
  # GET /groups
  # GET /groups.json
  def index
    #@current_season_id = Season.where(:seasonNo=> Setting.where(:settingName => 'Aktiw_tapgyr')[0].settingValue)[0].id  # Get id of current season from Settings object
    @current_season_id = session[:active_season_id]
    @groups = Group.where(:season_id => @current_season_id).order(:groupTitle)                                          # Get contracts list from current season
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @current_group_contracts = Contract.where(:group_id => @group.id, :isMoneyReturned => false)
    #@@current_group = @current_group_contracts
    @temp_string = "?count="+@current_group_contracts.count.to_s
    @counter = 0

    @current_group_contracts.each do |cg|
      @temp_string = @temp_string + "&cid[]="+cg.id.to_s
    end

    @current_group_student_id = Contract.select(:student_id).where(:group_id => @group.id, :isMoneyReturned => false)

    @tmp_array_of_student_ids = Array.new(Contract.where(:group_id => @group.id, :isMoneyReturned => false).select(:student_id).each{|el| el.student_id })

    @id_array = []
    @tmp_array_of_student_ids.each{|a| @id_array.push(a.student_id)}

    @male = Student.where(:id => @id_array, :gender => true)
    @female = Student.where(:id => @id_array, :gender => false)
    @group_students = Student.where(:id => @id_array).order(:fName)

    if (Season.find_by_seasonNo(Season.find_by_id(@group.season_id).seasonNo-1))
      @prev_season = Season.find_by_seasonNo(Season.find_by_id(@group.season_id).seasonNo-1)
      @prev_contracts_list = Contract.where(:student_id => @id_array, :season_id => @prev_season.id)
    end

    if (Season.find_by_seasonNo(Season.find_by_id(@group.season_id).seasonNo+1))
      @next_season = Season.find_by_seasonNo(Season.find_by_id(@group.season_id).seasonNo+1)
      @continuing_contracts_list = Contract.where(:student_id => @id_array, :season_id => @next_season.id)
    end
    #@continuing_contracts_list = Contract.where(:student_id => @id_array, :season_id => )

    @groupTimetable = Timetable.where(:group_id => @group.id)
    #@current_group_boys = Student.where(id: [Contract.select(:student_id).where(:group_id => @group.id).each_slice(1)])
    #@current_group_girls = Contract.where(:group_id => @group.id)

    @general_age_average = 0
    @male_age_average = 0
    @female_age_average = 0

    @male.each do |ml|
      @age = Date.today.year-ml.birthDate.year
        @age -= 1 if Date.today < ml.birthDate + @age.years
      @male_age_average = @male_age_average + @age
    end

    @female.each do |fml|
      @age = Date.today.year-fml.birthDate.year
      @age -= 1 if Date.today < fml.birthDate + @age.years
      @female_age_average = @female_age_average + @age
    end

    (@male.count>0 || @female.count>0) ? (@general_age_average = (@male_age_average + @female_age_average) /  (@male.count + @female.count)) : 0
    (@male.count>0) ? (@male_age_average = @male_age_average/@male.count) : 0
    (@female.count>0) ? (@female_age_average = @female_age_average/@female.count) : 0
  end

  # GET /groups/new
  def new
    @group = Group.new
    #@group.season_id = Season.where(:seasonNo=> Setting.where(:settingName => 'Aktiw_tapgyr')[0].settingValue)[0].id  # Get id of current season from Settings object
    @group.season_id = session[:active_season_id]
    @subjects = Subject.all.order(:subjectFullName)
    @seasons = Season.all.order(:seasonTitle)
    @lessonTimes = LessonTime.all.order(:lessonTimeTitle)
    @teachers = Teacher.all.order(:teacherFName)
    @groupGenders = GroupGender.all.order(:groupGenderShortName)
    @groupLanguages = GroupLanguage.all.order(:groupLanguageShortName)
  end

  # GET /groups/1/edit
  def edit
    @subjects = Subject.all.order(:subjectFullName)
    @seasons = Season.all.order(:seasonTitle)
    @lessonTimes = LessonTime.all.order(:lessonTimeTitle)
    @teachers = Teacher.all.order(:teacherFName)
    @groupGenders = GroupGender.all.order(:groupGenderShortName)
    @groupLanguages = GroupLanguage.all.order(:groupLanguageShortName)
  end

  # GET /groups/1
  # GET /groups/1.json
  def attendance_report
    @season_start_date = @group.season.seasonFromDate
    @season_end_date = @group.season.seasonToDate

    @group_lesson_weekdays = @group.timetables.select(:weekday)
    @weekday_array = []
    @group_lesson_weekdays.each{|a| @weekday_array.push(a.weekday)}

    render :layout => 'nosidebar'
  end

  # GET /agaly_report
  # GET /agaly_report.json
  def agaly_report
    #@current_season_id = Season.where(:seasonNo=> Setting.where(:settingName => 'Aktiw_tapgyr')[0].settingValue)[0].id  # Get id of current season from Settings object
    @current_season_id = session[:active_season_id]
    @report_groups = Group.where(:season_id => @current_season_id).order(:groupTitle)                                          # Get contracts list from current season
  end


  # GET /groups/1
  # GET /groups/1.json
  def info_list
    @tmp_array_of_student_ids = Array.new(Contract.where(:group_id => @group.id, :isMoneyReturned => false).select(:student_id).each{|el| el.student_id })

    @id_array = []
    @tmp_array_of_student_ids.each{|a| @id_array.push(a.student_id)}

    @group_students = Student.where(:id => @id_array).order(:fName)

    render :layout => false
  end

  # GET /groups/1
  # GET /groups/1.json
  def attendance_list
    @tmp_array_of_student_ids = Array.new(Contract.where(:group_id => @group.id, :isMoneyReturned => false).select(:student_id).each{|el| el.student_id })

    @id_array = []
    @tmp_array_of_student_ids.each{|a| @id_array.push(a.student_id)}

    @group_students = Student.where(:id => @id_array).order(:fName)

    render :layout => false
  end

  def availability
    @current_season_id = session[:active_season_id]
    @current_season = Season.find_by_id(@current_season_id)

    #if (@current_season_groups.nil?)
    #@current_season_groups = @current_season.cached_current_season_open_groups
    @current_season_groups = Group.where(:season_id =>@current_season_id, :isClosed => false)
    #end


    @current_season_contracts = Contract.where(:isMoneyReturned => false, :season_id => @current_season_id)
    #@current_season_contracts = @current_season.cached_current_season_active_contracts

    #@current_season_timetables = @current_season.cached_current_season_timetables
    @current_season_timetables = Timetable.where(:group_id => @current_season_groups.select(:id))

    @subject_categories = SubjectCategory.all.order(:subjectCategoryFullName)
    @lessonTimes = LessonTime.all.order(:lessonTimeFrom)
    render  :layout => 'nosidebar'
  end


  # GET /groups
  # GET /groups.json
  def availability_granica
    @current_season_id = session[:active_season_id]
    @current_season = Season.find_by_id(@current_season_id)

    @curren_season_groups = Group.where(:isClosed => false, :season_id => @current_season_id)
    #@current_season_groups = @current_season.cached_current_season_open_groups

    @curren_season_contracts = Contract.where(:isMoneyReturned => false, :season_id => @current_season_id)
    #@current_season_contracts = @current_season.cached_current_season_active_contracts

    @curren_season_timetables = Timetable.where(:group_id => @curren_season_groups.select(:id))
    #@current_season_timetables = @current_season.cached_current_season_timetables

    @subject_categories = SubjectCategory.all.order(:subjectCategoryFullName)
    @lessonTimes = LessonTime.all.order(:lessonTimeFrom)

    render  :layout => 'nosidebar'
  end

  # GET /information
  # GET /information.json
  def information
    @groups = Group.where(:isClosed => false)

    #@timetables = Timetable.all
    #@current_season_id = Season.where(:seasonNo=> Setting.where(:settingName => 'Aktiw_tapgyr')[0].settingValue)[0].id  # Get id of current season from Settings object
    @current_season_id = session[:active_season_id]
    #@temp_groups = Group.where(:season_id => @current_season[0])
    #@current_groups = Group.where(:season_id => @current_season_id).order(:groupTitle)                                  # Get groups in current season

    @current_english_groups = Group.where("season_id=? and subject_id=?", @current_season_id, SubjectCategory.where(:subjectCategoryFullName => "English")[0].id).order(:groupTitle)  # Get English groups in current season
    @current_english_groups = @current_english_groups.where(:isClosed => false)
    @current_turkish_groups = Group.where("season_id=? and subject_id=?", @current_season_id, SubjectCategory.where(:subjectCategoryFullName => "Türkçe")[0].id).order(:groupTitle)  # Get Turkish groups in current season
    @current_turkish_groups = @current_turkish_groups.where(:isClosed => false)
    @current_russian_groups = Group.where("season_id=? and subject_id=?", @current_season_id, SubjectCategory.where(:subjectCategoryFullName => "Rusça")[0].id).order(:groupTitle)  # Get Russian groups in current season
    @current_russian_groups = @current_russian_groups.where(:isClosed => false)

    @current_computer_groups = Group.where("season_id=? and subject_id=?", @current_season_id, SubjectCategory.where(:subjectCategoryFullName => "Kompýuter")[0].id).order(:groupTitle)  # Get Computer groups in current season
    @current_computer_groups = @current_computer_groups.where(:isClosed => false)
    @current_maths_groups = Group.where("season_id=? and subject_id=?", @current_season_id, SubjectCategory.where(:subjectCategoryFullName => "Matematika")[0].id).order(:groupTitle)  # Get Maths groups in current season
    @current_maths_groups = @current_maths_groups.where(:isClosed => false)

    render :layout => "nosidebar"

  end


  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)

    #@group.season_id = session[:active_season_id]
    @seasons = Season.all.order(:id)
    @subjects = Subject.all.order(:subjectFullName)
    @seasons = Season.all.order(:seasonTitle)
    @lessonTimes = LessonTime.all.order(:lessonTimeTitle)
    @teachers = Teacher.all.order(:teacherFName)
    @groupGenders = GroupGender.all.order(:groupGenderShortName)
    @groupLanguages = GroupLanguage.all.order(:groupLanguageShortName)

    respond_to do |format|
      if @group.save
        Season.flush_open_groups_cache

        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        Season.flush_open_groups_cache

        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:subject_id, :season_id, :lesson_time_id, :teacher_id, :group_gender_id, :group_language_id, :groupTitle, :isClosed, :groupLimit, :notes)
    end
end
