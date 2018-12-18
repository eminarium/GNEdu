class AttendancesController < ApplicationController
  before_action :set_attendance, only: [:show, :edit, :update, :destroy]
  before_action 'check_access', only: [:index, :show, :new, :edit, :destroy]

  # GET /attendances
  # GET /attendances.json
  def index
    @attendances = Attendance.all
  end

  # GET /attendances/1
  # GET /attendances/1.json
  def show
  end

  # GET /attendances
  # GET /attendances.json
  def sms_sender
    @sms_receivers = Attendance.where("is_sent=? and (lesson_1=? or lesson_2=? or lesson_3=?)", false, false, false, false)
    render :layout => 'nosidebar'
  end

  # GET /attendances/new
  def new
    @attendance = Attendance.new
  end

=begin
  def new
    @gatnasyklar = []

    Integer(params[:count]).times do
      @gatnasyklar << Attendance.new
    end

  end
=end

  # GET /attendances/1/edit
  def edit
  end

  # POST /attendances
  # POST /attendances.json
  def create
    #@attendance = Attendance.new(attendance_params)
    #@contract = Contract.find(params["attendances_attributes"][0][:contract_id])
    #@attendance = @contract.attendances.new(:contract_id => @contract.id)
    @attendance = Attendance.new(attendance_params)
    #@attendance = @contract.attendances.new(attendance_params)

    respond_to do |format|
      if @attendance.save
        format.html { redirect_to @attendance, notice: 'Attendance was successfully created.' }
        format.json { render :show, status: :created, location: @attendance }
      else
        format.html { render :new }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end



  # PATCH/PUT /attendances/1
  # PATCH/PUT /attendances/1.json
  def update
    respond_to do |format|
      if @attendance.update(attendance_params)
        format.html { redirect_to @attendance, notice: 'Attendance was successfully updated.' }
        format.json { render :show, status: :ok, location: @attendance }
      else
        format.html { render :edit }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attendances/1
  # DELETE /attendances/1.json
  def destroy
    @attendance.destroy
    respond_to do |format|
      format.html { redirect_to attendances_url, notice: 'Attendance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendance
      @attendance = Attendance.find(params[:id])
    end

     #Never trust parameters from the scary internet, only allow the white list through.
    def attendance_params
      params.require(:attendance).permit(:contract_id, :attendance_sheet_id, :lesson_1, :lesson_2, :lesson_3, :attendanceNotes, :is_sent)
    end


end
