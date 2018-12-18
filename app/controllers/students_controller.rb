class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy, :info_list]
  before_action 'check_access', only: [:index, :show, :new, :edit, :search, :repeating, :info_list, :health_notes_report]

  # GET /students
  # GET /students.json
  def index
    @students = Student.all
    #@students = Student.where(:id => params[:id])
    ##@current_season = Season.where(:seasonNo=> Setting.where(:settingName => 'Aktiw_tapgyr')[0].settingValue)[0]  # Get season number of current season from Settings object
  end

  # GET /students
  # GET /students.json
  def search
    @current_season =  Season.find_by_id(session[:active_season_id]) # Get season number of current season from Settings object
    #@students = Student.where(:fName => params[:fName])
    if (params[:fName].blank? && params[:lName].blank? && params[:patronymic].blank? && params[:mobilePhone].blank? && params[:smsMobilePhone].blank? && params[:homePhone].blank?)
      @students = Student.where(:fName => "", :lName => "", :patronymic => "")
    else
      @students = Student.where(" lower(\"fName\") LIKE ? and lower(\"lName\") LIKE ? and lower(patronymic) LIKE ? and lower(\"mobilePhone\") LIKE ? and lower(\"smsMobilePhone\") LIKE ? and lower(\"homePhone\") LIKE ?", "%#{params[:fName].mb_chars.downcase}%", "%#{params[:lName].mb_chars.downcase}%", "%#{params[:patronymic].mb_chars.downcase}%", "%#{params[:mobilePhone].mb_chars.downcase}%", "%#{params[:smsMobilePhone].mb_chars.downcase}%", "%#{params[:homePhone].mb_chars.downcase}%")
    end
    ##@current_season = Season.where(:seasonNo=> Setting.where(:settingName => 'Aktiw_tapgyr')[0].settingValue)[0]  # Get season number of current season from Settings object
  end

  # GET /students/1
  # GET /students/1.json
  def show
    ##@current_season = Season.where(:seasonNo=> Setting.where(:settingName => 'Aktiw_tapgyr')[0].settingValue)[0]  # Get season number of current season from Settings object -- son acmaly
  end

  # GET /students/1
  # GET /students/1.json
  def info_list
    ##@current_season = Season.where(:seasonNo=> Setting.where(:settingName => 'Aktiw_tapgyr')[0].settingValue)[0]  # Get season number of current season from Settings object -- son acmaly
    render :layout => false
  end

  # GET /repeating
  # GET /repeating.json
  def repeating
    #@duplicate_students = Student.find_by_sql("select \"fName\", \"lName\", patronymic, \"birthDate\", count(id) from students group by \"fName\", \"lName\", patronymic, \"birthDate\" having count(id)>1")
    @duplicate_students = Student.find_by_sql("select \"fName\", \"lName\", patronymic, count(id) from students group by \"fName\", \"lName\", patronymic having count(id)>1")
    #@duplicate_students = Student.find_by_sql("select TRIM(\"fName\"), TRIM(\"lName\"), TRIM(patronymic), count(id) from students group by \"fName\", \"lName\", patronymic having count(*)>1")
    #@duplicate_students = Student.select("\"fName\", \"lName\", patronymic").group(:fName, :lName, :patronymic).having("count(id) > 1")

  end

  # GET /students/new
  def new
    @student = Student.new
    @student.nationality_id = Nationality.where(:nationalityName => "Türkmen")[0].id  # default nationality is "Türkmen"
    @nationalities= Nationality.all.order(:nationalityName)
    @highSchools = HighSchool.all.order(:highSchoolName)
    @specialSchools = SpecialSchool.all.order(:specialSchoolName)
    @states = State.all
    @cities = City.all.order(:cityName)
  end

  # GET /students/1/edit
  def edit
    @nationalities= Nationality.all.order(:nationalityName)
    @highSchools = HighSchool.all.order(:highSchoolName)
    @specialSchools = SpecialSchool.all.order(:specialSchoolName)
    @states = State.all
    @cities = City.all.order(:cityName)
  end

  # POST /students
  # POST /students.json
  def create
    @nationalities= Nationality.all.order(:nationalityName)
    @highSchools = HighSchool.all.order(:highSchoolName)
    @specialSchools = SpecialSchool.all.order(:specialSchoolName)
    @states = State.all
    @cities = City.all.order(:cityName)

    ##@current_season = Season.where(:seasonNo=> Setting.where(:settingName => 'Aktiw_tapgyr')[0].settingValue)[0]  # Get season number of current season from Settings object -- son acmaly
    ##@current_season_contracts_next_no = Contract.where(:season_id => @current_season.id).maximum(:seasonContractNo)+1  -- son acmaly
    ##@next_max_stud_id = Student.maximum(:id)+1  -- son acmaly

    uploaded_io = params[:student][:imageUrl]
    @next_max_stud_id = Student.maximum(:id)+1

    if uploaded_io
      File.open(Rails.root.join('public', 'uploads/images/', @next_max_stud_id.to_s+".jpg"), 'wb') do |file|
        file.write(uploaded_io.read)
      end

      params[:student][:imageUrl] = @next_max_stud_id.to_s+".jpg"
    else
      params[:student][:imageUrl] = ""
    end

    @student = Student.new(student_params)

    #@duplicate_student = Student.where(:fName => @student.fName, :lName => @student.lName, :patronymic => @student.patronymic, :birthDate => @student.birthDate)

    respond_to do |format|

      #@duplicate_students=Student.where("(lower(\"fName\")) = ?", "%#{@student.fName.to_s.downcase}%")
      @duplicate_students = Student.where(:fName => @student.fName, :lName => @student.lName, :patronymic => @student.patronymic, :birthDate => @student.birthDate)
      @duplicate_message = "BIRMEŇZEŞ MAGLUMATLY DIŇLEÝJI ULGAMDA BAR => "
      #@if_saved = @student.save

      if ((@duplicate_students.count==0) && (@student.save))
        format.html { redirect_to @student, notice: 'Täze diňleýji üstünlikli girizildi !' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    ##@current_season = Season.where(:seasonNo=> Setting.where(:settingName => 'Aktiw_tapgyr')[0].settingValue)[0]  # Get season number of current season from Settings object -- son acmaly
    ##@current_season_contracts_next_no = Contract.where(:season_id => @current_season.id).maximum(:seasonContractNo)+1  -- son acmaly

    @nationalities= Nationality.all.order(:nationalityName)
    @highSchools = HighSchool.all.order(:highSchoolName)
    @specialSchools = SpecialSchool.all.order(:specialSchoolName)
    @states = State.all
    @cities = City.all.order(:cityName)

    if params[:student][:imageUrl]
      uploaded_io = params[:student][:imageUrl]
      File.open(Rails.root.join('public', 'uploads/images/', @student.id.to_s+".jpg"), 'wb') do |file|
        file.write(uploaded_io.read)
      end

      params[:student][:imageUrl] = @student.id.to_s+".jpg"
    end

    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Diňleýji maglumatlary üstünlikli üýtgedildi.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy

    if (File.exist?(Rails.root.join('public', 'uploads/images/', @student.imageUrl.to_s)) && !@student.imageUrl.blank?)
      FileUtils.rm(Rails.root.join('public', 'uploads/images/', @student.imageUrl.to_s))
    end

    @student.destroy

    respond_to do |format|
      format.html { redirect_to search_students_url, notice: 'Diňleýji üstünlikli bozuldy.' }
      format.json { head :no_content }
    end
  end

=begin

  def upload

    #@current_season = Season.where(:seasonNo=> Setting.where(:settingName => 'Aktiw_tapgyr')[0].settingValue)[0]  # Get season number of current season from Settings object
    @current_season =  Sesson.find_by_id(session[:active_season_id]) # Get season number of current season from Settings object


    if params[:student][:imageUrl]
      uploaded_io = params[:student][:imageUrl]
      File.open(Rails.root.join('public','uploads/images/',uploaded_io.original_filename), 'wb') do |file|
        file.write(uploaded_io.read)
      end
    end
  end

=end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:nationality_id, :imageUrl, :fName, :lName, :patronymic, :gender, :birthDate, :smsMobilePhone, :homePhone,:city_id, :addressBody, :isPupil, :isStudent, :isWorker, :faFName, :faLName, :faWorkPlace, :faOccupation, :faOfficePhone, :faMobilePhone, :maFName, :maLName, :maWorkPlace, :maOccupation, :maOfficePhone, :maMobilePhone, :workPlace, :occupation, :officePhone, :mobilePhone, :high_school_id, :special_school_id, :highSpecialSchoolOther, :highSpecialSchoolYear, :schoolNo, :schoolName, :schoolYear, :school_city_id, :diseaseNotes, :notes)
    end
end
