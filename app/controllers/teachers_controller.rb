class TeachersController < ApplicationController
  before_action :set_teacher, only: [:show, :edit, :update, :destroy]
  before_action 'check_access', only: [:index, :show, :new, :edit, :destroy]

  # GET /teachers
  # GET /teachers.json
  def index
    @teachers = Teacher.all.order(:teacherFName)

    @current_season_groups = Group.where(:season_id => session[:active_season_id])

    @active_teachers = @teachers.where(:id => @current_season_groups.select(:teacher_id))
    @inactive_teachers = @teachers.where.not(:id => @active_teachers.select(:id))
  end

  # GET /teachers/1
  # GET /teachers/1.json
  def show

    #params[:teacher][:group_id].each do |item|       # A block of code to set current note sharing options with other users
      #Group.find_by_id(:id => item).teacher_id = @teacher.id
    #end
    #@result = params[:teacher][:group_id].inspect

    if (defined? params[:teacher][:group_id])
      params[:teacher][:group_id].each do |gid|
        if (!(gid.blank?))
          Group.find_by_id(gid).update_attribute(:teacher_id, @teacher.id)
        end
      end
    end

    if (defined? params[:teacher][:group_id])
      Group.where(:season_id => session[:active_season_id], :isClosed => false, :teacher_id => @teacher.id).where.not(:id => params[:teacher][:group_id]).each do |gid|
        Group.find_by_id(gid).update_attribute(:teacher_id, nil)
      end
    end
    #@current_season_id = Season.where(:seasonNo=> Setting.where(:settingName => 'Aktiw_tapgyr')[0].settingValue)[0].id
    @current_season_id = session[:active_season_id]

    if (Season.find_by_seasonNo(Season.find_by_id(@current_season_id).seasonNo-1))
      @previous_season_id = Season.find_by_seasonNo(Season.find_by_id(@current_season_id).seasonNo-1).id
      @teachersPreviousGroups = Group.where(:season_id => @previous_season_id, :teacher_id => @teacher.id)
    else
      @teachersPreviousGroups = nil
    end

    @teachersCurrentGroups = Group.where(:season_id => @current_season_id, :teacher_id => @teacher.id)

    @teachersGroupHistory = Group.where(:teacher_id => @teacher.id).order(season_id: :desc)


  end

  # GET /teachers/new
  def new
    @teacher = Teacher.new
    @users = User.all
  end

  # GET /teachers/1/edit
  def edit
    @users = User.all
  end


  # GET /teachers/1/edit
  def groups_list
    @groups = Group.where(:season_id => session[:active_season_id], :isClosed => false)

    @tmp_array_of_group_ids = Array.new(Group.where(:season_id => session[:active_season_id], :teacher_id => params[:id], :isClosed => false).select(:id))

    @id_array = []
    @tmp_array_of_group_ids.each{|a| @id_array.push(a.id)}

    #@id_array = Array.new(Group.where(:season_id => session[:active_season_id], :teacher_id => @teacher.id, :isClosed => false).select(:id).each{|el| el.id})
  end

  # POST /teachers
  # POST /teachers.json
  def create
    @teacher = Teacher.new(teacher_params)

    respond_to do |format|
      if @teacher.save
        format.html { redirect_to @teacher, notice: 'Teacher was successfully created.' }
        format.json { render :show, status: :created, location: @teacher }
      else
        format.html { render :new }
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teachers/1
  # PATCH/PUT /teachers/1.json
  def update
    respond_to do |format|
      if @teacher.update(teacher_params)
        format.html { redirect_to @teacher, notice: 'Teacher was successfully updated.' }
        format.json { render :show, status: :ok, location: @teacher }
      else
        format.html { render :edit }
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teachers/1
  # DELETE /teachers/1.json
  def destroy
    @teacher.destroy
    respond_to do |format|
      format.html { redirect_to teachers_url, notice: 'Teacher was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teacher
      @teacher = Teacher.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def teacher_params
      params.require(:teacher).permit(:user_id, :teacherFName, :teacherLName, :teacherPatronymic, :gender, :notes)
    end
end
