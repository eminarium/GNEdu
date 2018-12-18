class UserSessionsController < ApplicationController
  before_action :set_user_session, only: [:show, :edit, :update, :destroy]
  before_action 'check_access', only: [:welcome_admin, :welcome_examinator, :welcome_librarian, :welcome_registrar, :welcome_teacher, :welcome_observer, :welcome_dep_manager, :welcome_testing_manager]

  # GET /user_sessions
  # GET /user_sessions.json
  #def index
    #@user_sessions = UserSession.all
  #end

  # GET /user_sessions/1
  # GET /user_sessions/1.json
  #def show
  #end

  # GET /user_sessions/new
  def new
    @user_session = UserSession.new
    render :layout => false
  end

  # GET /user_sessions/1/edit
  def edit
  end

  # GET /user_sessions
  # GET /user_sessions.json
  def welcome_admin
    @current_season = Season.find_by_id(session[:active_season_id])
    @events = Event.all
    @book_contests = BookContest.where(:season_id => @current_season.id)
    @book_contest = @book_contests.first


    if (Season.where("\"seasonFromDate\" <= ? AND \"seasonToDate\" >= ?", DateTime.now, DateTime.now).empty?)
      @new_season = Season.find_by_id(session[:active_season_id])
      @ongoing_season = @new_season
    else
      @ongoing_season_id = Season.where("\"seasonFromDate\" <= ? AND \"seasonToDate\" >= ?", DateTime.now, DateTime.now).first.id
      @ongoing_season = Season.find_by_id(@ongoing_season_id)
      @new_season = @ongoing_season
    end

    @ongoing_season_tests = SeasonTest.where(:season_id => @ongoing_season.id).order(:seasonTestDate)
    @new_season_tests = SeasonTest.where(:season_id => @new_season.id).order(:seasonTestDate)

    # Show duplicate and groupless contracts and students.
    @duplicate_contracts = Contract.where(:season_id => session[:active_season_id]).find_by_sql("select student_id, group_id, \"isMoneyReturned\", count(*) from contracts group by student_id, group_id, \"isMoneyReturned\" having count(*)>1")
    @groupless_contracts = Contract.where(:season_id => session[:active_season_id], :group_id => NIL)
    @duplicate_students = Student.find_by_sql("select \"fName\", \"lName\", patronymic, count(id) from students group by \"fName\", \"lName\", patronymic having count(id)>1")

    # To calculate photoless students of current season.
    @current_season_contracts = Contract.where(:season_id => @current_season.id, :isMoneyReturned => false).includes(:season, :group, :student, :final).order(:seasonContractNo)                              # Get contracts list from current season
    @lesson_times = LessonTime.all.order(:lessonTimeFrom)

    # Tapgyr Maglumatlary ####################################################################################
    @current_season_contracts = Contract.where(:season_id => @current_season.id, :isMoneyReturned => false)
    @current_season_student_id = @current_season_contracts.select(:student_id)

    @tmp_array_of_student_ids = Array.new(@current_season_student_id.each{|el| el.student_id })

    @id_array = []
    @tmp_array_of_student_ids.each{|a| @id_array.push(a.student_id)}

    @season_students = Student.where(:id => @id_array).order(:fName)
    @students_with_incorrect_phones = @season_students.where("(length(\"mobilePhone\")>0 AND length(\"mobilePhone\") <> 8) OR length(\"smsMobilePhone\") <> 8")

    if (Season.find_by_seasonNo(Season.find_by_id(@current_season.id).seasonNo-1))
      @prev_season = Season.find_by_seasonNo(Season.find_by_id(@current_season.id).seasonNo-1)
      @prev_contracts_list = Contract.where(:student_id => @id_array, :season_id => @prev_season.id, :isMoneyReturned => false)
    end

    @teachers = Teacher.all.order(:teacherFName)
    @current_season_groups = Group.where(:season_id => @ongoing_season_id)
    @active_teachers = @teachers.where(:id => @current_season_groups.select(:teacher_id))  # Şu tapgyrda okadýan mugallymlar sanawy

  end

  # GET /user_sessions
  # GET /user_sessions.json
  def welcome_registrar
    @current_season = Season.find_by_id(session[:active_season_id])
    @events = Event.all
    @book_contests = BookContest.where(:season_id => @current_season.id)
    @book_contest = @book_contests.first

    if (Season.where("\"seasonFromDate\" <= ? AND \"seasonToDate\" >= ?", DateTime.now, DateTime.now).empty?)
      @new_season = Season.find_by_id(session[:active_season_id])
      @ongoing_season = @new_season
    else
      @ongoing_season_id = Season.where("\"seasonFromDate\" <= ? AND \"seasonToDate\" >= ?", DateTime.now, DateTime.now).first.id
      @ongoing_season = Season.find_by_id(@ongoing_season_id)
      @new_season = @ongoing_season
    end

    @ongoing_season_tests = SeasonTest.where(:season_id => @ongoing_season.id).order(:seasonTestDate)
    @new_season_tests = SeasonTest.where(:season_id => @new_season.id).order(:seasonTestDate)


    # Show duplicate and groupless contracts and students.
    @duplicate_contracts = Contract.where(:season_id => session[:active_season_id]).find_by_sql("select student_id, group_id, \"isMoneyReturned\", count(*) from contracts group by student_id, group_id, \"isMoneyReturned\" having count(*)>1")
    @groupless_contracts = Contract.where(:season_id => session[:active_season_id], :group_id => NIL)
    @duplicate_students = Student.find_by_sql("select \"fName\", \"lName\", patronymic, count(id) from students group by \"fName\", \"lName\", patronymic having count(id)>1")

    # To calculate photoless students of current season.
    @current_season_contracts = Contract.where(:season_id => @current_season.id, :isMoneyReturned => false).includes(:season, :group, :student, :final).order(:seasonContractNo)                              # Get contracts list from current season
    @lesson_times = LessonTime.all.order(:lessonTimeFrom)

    # Tapgyr Maglumatlary #################################################################################
    @current_season_contracts = Contract.where(:season_id => @current_season.id, :isMoneyReturned => false)
    @current_season_student_id = @current_season_contracts.select(:student_id)

    @tmp_array_of_student_ids = Array.new(@current_season_student_id.each{|el| el.student_id })

    @id_array = []
    @tmp_array_of_student_ids.each{|a| @id_array.push(a.student_id)}

    @season_students = Student.where(:id => @id_array).order(:fName)
    @students_with_incorrect_phones = @season_students.where("(length(\"mobilePhone\")>0 AND length(\"mobilePhone\") <> 8) OR length(\"smsMobilePhone\") <> 8")

    if (Season.find_by_seasonNo(Season.find_by_id(@current_season.id).seasonNo-1))
      @prev_season = Season.find_by_seasonNo(Season.find_by_id(@current_season.id).seasonNo-1)
      @prev_contracts_list = Contract.where(:student_id => @id_array, :season_id => @prev_season.id, :isMoneyReturned => false)
    end

    @teachers = Teacher.all.order(:teacherFName)
    @current_season_groups = Group.where(:season_id => @ongoing_season_id)
    @active_teachers = @teachers.where(:id => @current_season_groups.select(:teacher_id))  # Şu tapgyrda okadýan mugallymlar sanawy

  end

  def welcome_examinator
    #@user_sessions = UserSession.all
    @events = Event.all
    @current_season = Season.find_by_id(session[:active_season_id])
    @season_tests = SeasonTest.where(:season_id => session[:active_season_id]).order(:seasonTestDate)
    @lesson_times = LessonTime.all.order(:lessonTimeFrom)
  end

  def welcome_observer
    #@user_sessions = UserSession.all
    @events = Event.all
    @current_season = Season.find_by_id(session[:active_season_id])
    @season_tests = SeasonTest.where(:season_id => session[:active_season_id]).order(:seasonTestDate)
    @lesson_times = LessonTime.all.order(:lessonTimeFrom)
  end

  def welcome_teacher
    #@user_sessions = UserSession.all
    @last_signed_in = Audit.where(:user_id => current_user.id, :mod_action_id => ModAction.where(:modActionName => "create", :mod_object_id => ModObject.find_by_modObjectName("user_sessions").id).first().id).order(:id).last

    @book_contests = BookContest.where(:season_id => session[:active_season_id])
    @book_contest = @book_contests.first

    @events = Event.all
    @current_season = Season.find_by_id(session[:active_season_id])
    @season_tests = SeasonTest.where(:season_id => session[:active_season_id]).order(:seasonTestDate)
    @lesson_times = LessonTime.all.order(:lessonTimeFrom)
  end

  def welcome_dep_manager
    #@user_sessions = UserSession.all
    @book_contests = BookContest.where(:season_id => session[:active_season_id])
    @book_contest = @book_contests.first

    @events = Event.all
    @current_season = Season.find_by_id(session[:active_season_id])
    @season_tests = SeasonTest.where(:season_id => session[:active_season_id]).order(:seasonTestDate)
    @lesson_times = LessonTime.all.order(:lessonTimeFrom)
  end

  def welcome_testing_manager
    #@user_sessions = UserSession.all
    @book_contests = BookContest.where(:season_id => session[:active_season_id])
    @book_contest = @book_contests.first

    @events = Event.all
    @current_season = Season.find_by_id(session[:active_season_id])
    @season_tests = SeasonTest.where(:season_id => session[:active_season_id]).order(:seasonTestDate)
    @lesson_times = LessonTime.all.order(:lessonTimeFrom)
  end

  def welcome_librarian
    #@user_sessions = UserSession.all
    @events = Event.all
  end

  # POST /user_sessions
  # POST /user_sessions.json
  def create
    @user_session = UserSession.new(user_session_params)

    respond_to do |format|
      if @user_session.save

        register_audit (current_user.id)

        # Check if default season is set for this role.
        #if (current_user.role.season) # if logged in users active season is defined ?
          #session[:active_season_id] = current_user.role.season.id
        #else  # else the user gets system default active season.
          #session[:active_season_id] = Season.where(:seasonNo=> Setting.where(:settingName => 'Aktiw_tapgyr')[0].settingValue)[0].id  # Get id of current season from Settings object
        #end

        if (current_user.isBlocked)
          #redirect_to welcome_librarian_url
          format.html { render 'layouts/restricted', :layout => 'nosidebar' }
        elsif (current_user.role.name == "examinator")
          format.html { redirect_to welcome_examinator_url }
        elsif (current_user.role.name == "observer")

          if (current_user.role.season) # if logged in users active season is defined ?
            session[:active_season_id] = current_user.role.season.id
          elsif (Season.where("\"seasonFromDate\" <= ? AND \"seasonToDate\" >= ?", DateTime.now, DateTime.now).empty?)
            #session[:active_season_id] = Season.find_by_id(session[:active_season_id]).id
            session[:active_season_id] = Season.find_by_seasonNo(Setting.find_by_settingName('Aktiw_tapgyr').settingValue).id  # Get id of current season from Settings object
          else
            session[:active_season_id] = Season.where("\"seasonFromDate\" <= ? AND \"seasonToDate\" >= ?", DateTime.now, DateTime.now).first.id
          end

          format.html { redirect_to welcome_observer_url }
        elsif (current_user.role.name == "librarian")

          if (Season.where("\"seasonFromDate\" <= ? AND \"seasonToDate\" >= ?", DateTime.now, DateTime.now).empty?)
            session[:active_season_id] = Season.find_by_seasonNo(Setting.find_by_settingName('Aktiw_tapgyr').settingValue).id
          else
            session[:active_season_id] = Season.where("\"seasonFromDate\" <= ? AND \"seasonToDate\" >= ?", DateTime.now, DateTime.now).first.id
            @ongoing_season = Season.find_by_id(@ongoing_season_id)
          end

          format.html { redirect_to welcome_librarian_url }

        elsif (current_user.role.name == "registrar")

          if (current_user.role.season) # if logged in users active season is defined ?
            session[:active_season_id] = current_user.role.season.id
          elsif (Season.where("\"seasonFromDate\" <= ? AND \"seasonToDate\" >= ?", DateTime.now, DateTime.now).empty?)
            #session[:active_season_id] = Season.find_by_id(session[:active_season_id]).id
            session[:active_season_id] = Season.where(:seasonNo=> Setting.where(:settingName => 'Aktiw_tapgyr')[0].settingValue)[0].id  # Get id of current season from Settings object
          else
            session[:active_season_id] = Season.where("\"seasonFromDate\" <= ? AND \"seasonToDate\" >= ?", DateTime.now, DateTime.now).first.id
          end

          format.html { redirect_to welcome_registrar_url }
        elsif (current_user.role.name == "admin")

          if (Season.where("\"seasonFromDate\" <= ? AND \"seasonToDate\" >= ?", DateTime.now, DateTime.now).empty?)
            session[:active_season_id] = Season.find_by_seasonNo(Setting.find_by_settingName('Aktiw_tapgyr').settingValue).id
          else
            session[:active_season_id] = Season.where("\"seasonFromDate\" <= ? AND \"seasonToDate\" >= ?", DateTime.now, DateTime.now).first.id
          end

          format.html { redirect_to welcome_admin_url }

        elsif (current_user.role.name == "teacher")

          if (Season.where("\"seasonFromDate\" <= ? AND \"seasonToDate\" >= ?", DateTime.now, DateTime.now).empty?)
            session[:active_season_id] = Season.find_by_seasonNo(Setting.find_by_settingName('Aktiw_tapgyr').settingValue).id
          else
            session[:active_season_id] = Season.where("\"seasonFromDate\" <= ? AND \"seasonToDate\" >= ?", DateTime.now, DateTime.now).first.id
            @ongoing_season = Season.find_by_id(@ongoing_season_id)
          end
          format.html { redirect_to welcome_teacher_url }

        elsif (current_user.role.name == "dep_manager")

          if (Season.where("\"seasonFromDate\" <= ? AND \"seasonToDate\" >= ?", DateTime.now, DateTime.now).empty?)
            session[:active_season_id] = Season.find_by_seasonNo(Setting.find_by_settingName('Aktiw_tapgyr').settingValue).id
          else
            session[:active_season_id] = Season.where("\"seasonFromDate\" <= ? AND \"seasonToDate\" >= ?", DateTime.now, DateTime.now).first.id
            @ongoing_season = Season.find_by_id(@ongoing_season_id)
          end
           format.html { redirect_to welcome_dep_manager_url }

        elsif (current_user.role.name == "testing_manager")

          if (Season.where("\"seasonFromDate\" <= ? AND \"seasonToDate\" >= ?", DateTime.now, DateTime.now).empty?)
            session[:active_season_id] = Season.find_by_seasonNo(Setting.find_by_settingName('Aktiw_tapgyr').settingValue).id
          else
            session[:active_season_id] = Season.where("\"seasonFromDate\" <= ? AND \"seasonToDate\" >= ?", DateTime.now, DateTime.now).first.id
            @ongoing_season = Season.find_by_id(@ongoing_season_id)
          end
          format.html { redirect_to welcome_testing_manager_url }

        else
          format.html { redirect_to subjects_url }
          format.json { render :show, status: :created, location: @user_session }
        end

      else
        format.html { render :new, :layout => false }
        format.json { render json: @user_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_sessions/1
  # PATCH/PUT /user_sessions/1.json
  def update
    respond_to do |format|
      if @user_session.update(user_session_params)
        format.html { redirect_to @user_session, notice: 'User session was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_session }
      else
        format.html { render :new }
        format.json { render json: @user_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_sessions/1
  # DELETE /user_sessions/1.json
  def destroy
    if @user_session
      @user_session.destroy
      respond_to do |format|
        #format.html { redirect_to user_sessions_url, notice: 'User session was successfully destroyed.' }

        format.html { redirect_to :login }
        format.json { head :no_content }
      end
    else
      redirect_to :login
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_session
      @user_session = UserSession.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_session_params
      params.require(:user_session).permit(:userLogin, :password)
    end
end
