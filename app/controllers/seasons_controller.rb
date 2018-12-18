class SeasonsController < ApplicationController
  before_action :set_season, only: [:show, :edit, :update, :destroy, :change_active_season, :teachers_list, :info_list, :subject_report]
  before_action 'check_access', only: [:index, :show, :new, :edit, :destroy, :change_active_season, :teachers_list, :info_list, :subject_report]

  # GET /seasons
  # GET /seasons.json
  def index
    @seasons = Season.all
  end

  # GET /seasons/1
  # GET /seasons/1.json
  def show
    @current_season_contracts = Contract.where(:season_id => @season.id, :isMoneyReturned => false)
    @current_season_student_id = @current_season_contracts.select(:student_id)

    @tmp_array_of_student_ids = Array.new(@current_season_student_id.each{|el| el.student_id })

    @id_array = []
    @tmp_array_of_student_ids.each{|a| @id_array.push(a.student_id)}

    #@male = Student.where(:id => @id_array, :gender => true)
    #@female = Student.where(:id => @id_array, :gender => false)
    @season_students = Student.where(:id => @id_array).order(:fName)

    #@min_date = @season.seasonFromDate-18.years;
    #@age_18_and_up_students_id = @season_students.where(:birthDate<(@season.seasonFromDate - 18.years.ago));
    #@dt_min = Date.new(@season.seasonFromDate.year-11, @season.seasonFromDate.month, @season.seasonFromDate.day)
    #@dt_max = Date.new(@season.seasonFromDate.year-18, @season.seasonFromDate.month, @season.seasonFromDate.day)

    #@age_bw_11_and_18_students_id = @season_students.where(" \"birthDate\" >= ? AND  \"birthDate\" <= ?", @dt_max, @dt_min).select(:id);
    #@current_season_age_bw_11_and_18_contracts = @current_season_contracts.where(:student_id => @age_bw_11_and_18_students_id)

    #@age_18_and_up_students_id = @season_students.where(" \"birthDate\" <= ?", @dt_max).select(:id);
    #@current_season_age_18_and_up_contracts = @current_season_contracts.where(:student_id => @age_18_and_up_students_id)

    if (Season.find_by_seasonNo(Season.find_by_id(@season.id).seasonNo-1))
      @prev_season = Season.find_by_seasonNo(Season.find_by_id(@season.id).seasonNo-1)
      @prev_contracts_list = Contract.where(:student_id => @id_array, :season_id => @prev_season.id, :isMoneyReturned => false)
    end

    if (Season.find_by_seasonNo(Season.find_by_id(@season.id).seasonNo+1))
      @next_season = Season.find_by_seasonNo(Season.find_by_id(@season.id).seasonNo+1)
      @continuing_contracts_list = Contract.where(:student_id => @id_array, :season_id => @next_season.id, :isMoneyReturned => false)
    end
    #@continuing_contracts_list = Contract.where(:student_id => @id_array, :season_id => )


    @teachers = Teacher.all.order(:teacherFName)
    @current_season_groups = Group.where(:season_id => @season.id)
    @active_teachers = @teachers.where(:id => @current_season_groups.select(:teacher_id))

  end


  # GET /seasons/1
  # GET /seasons/1.json
  def subject_report
     render :layout => false
  end

  # GET /seasons/1
  # GET /seasons/1.json
  def teachers_list
    @teachers = Teacher.all.order(:teacherFName)
    @current_season_groups = Group.where(:season_id => session[:active_season_id])
    @active_teachers = @teachers.where(:id => @current_season_groups.select(:teacher_id))

    render :layout => false
  end

  # GET /seasons/1
  # GET /seasons/1.json
  def info_list

    @current_season_contracts = Contract.where(:season_id => @season.id, :isMoneyReturned => false)
    @current_season_student_id = @current_season_contracts.select(:student_id)

    @tmp_array_of_student_ids = Array.new(@current_season_student_id.each{|el| el.student_id })

    @id_array = []
    @tmp_array_of_student_ids.each{|a| @id_array.push(a.student_id)}

    #@male = Student.where(:id => @id_array, :gender => true)
    #@female = Student.where(:id => @id_array, :gender => false)
    @season_students = Student.where(:id => @id_array).order(:fName)

    @dt_min = Date.new(@season.seasonFromDate.year-11, @season.seasonFromDate.month, @season.seasonFromDate.day)
    @dt_max = Date.new(@season.seasonFromDate.year-18, @season.seasonFromDate.month, @season.seasonFromDate.day)

    #@age_bw_11_and_18_students_id = @season_students.where(" \"birthDate\" >= ? AND  \"birthDate\" <= ?", @dt_max, @dt_min).select(:id);
    #@current_season_age_bw_11_and_18_contracts = @current_season_contracts.where(:student_id => @age_bw_11_and_18_students_id)

    #@age_18_and_up_students_id = @season_students.where(" \"birthDate\" <= ?", @dt_max).select(:id);
    #@current_season_age_18_and_up_contracts = @current_season_contracts.where(:student_id => @age_18_and_up_students_id)

    if (Season.find_by_seasonNo(Season.find_by_id(@season.id).seasonNo-1))
      @prev_season = Season.find_by_seasonNo(Season.find_by_id(@season.id).seasonNo-1)
      @prev_contracts_list = Contract.where(:student_id => @id_array, :season_id => @prev_season.id)
    end

    if (Season.find_by_seasonNo(Season.find_by_id(@season.id).seasonNo+1))
      @next_season = Season.find_by_seasonNo(Season.find_by_id(@season.id).seasonNo+1)
      @continuing_contracts_list = Contract.where(:student_id => @id_array, :season_id => @next_season.id)
    end
    #@continuing_contracts_list = Contract.where(:student_id => @id_array, :season_id => )

    render :layout => false
  end

  # GET /seasons/new
  def new
    @season = Season.new
  end

  # GET /seasons/1
  # GET /seasons/1.json
  def change_active_season
    session[:active_season_id] = @season.id

    #Season.flush_open_groups_cache
    #Season.flush_season_active_contracts_cache
    #Season.flush_season_timetables_cache
  end

  # GET /seasons/1/edit
  def edit
 end

  # POST /seasons
  # POST /seasons.json
  def create
    @season = Season.new(season_params)

    respond_to do |format|
      if @season.save
        format.html { redirect_to @season, notice: 'Season was successfully created.' }
        format.json { render :show, status: :created, location: @season }
      else
        format.html { render :new }
        format.json { render json: @season.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /seasons/1
  # PATCH/PUT /seasons/1.json
  def update
    respond_to do |format|
      if @season.update(season_params)
        format.html { redirect_to @season, notice: 'Season was successfully updated.' }
        format.json { render :show, status: :ok, location: @season }
      else
        format.html { render :edit }
        format.json { render json: @season.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /seasons/1
  # DELETE /seasons/1.json
  def destroy
    @season.destroy
    respond_to do |format|
      format.html { redirect_to seasons_url, notice: 'Season was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_season
      @season = Season.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def season_params
      params.require(:season).permit(:seasonTitle, :seasonNo, :seasonFromDate, :seasonToDate, :return_deadline, :notes)
    end
end
