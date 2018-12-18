class AttendanceSheetsController < ApplicationController
  before_action :set_attendance_sheet, only: [:show, :edit, :update, :destroy]
  before_action 'check_access', only: [:index, :show, :new, :edit, :destroy]

  # GET /attendance_sheets
  # GET /attendance_sheets.json
  def index
    @attendance_sheets = AttendanceSheet.all
  end

  # GET /attendance_sheets/1
  # GET /attendance_sheets/1.json
  def show
  end

  # GET /attendance_sheets/new
  #def new
    #@attendance_sheet = AttendanceSheet.new
  #end

  # GET /attendance_sheets/new
  def new
    @attendance_sheet = AttendanceSheet.new
    @group = Group.find_by_id(params[:group_id])
    @attendance_sheet = @group.attendance_sheets.new

    if (!params[:attendanceSheetDate].blank?)
      @attendance_sheet.attendanceSheetDate = params[:attendanceSheetDate]
    end

=begin
  @group_contracts
=end

    @this_group_contracts = Contract.includes(:student).where(:isMoneyReturned => false, :group_id => @group.id).order('students.patronymic')
    #@group.contracts.where(:isMoneyReturned => false).each do |gc|
    @this_group_contracts.each do |gc|
      @attendance_sheet.attendances << Attendance.new(:contract => gc)
    end

    #@attendance_sheet.attendances = @group.contract_ids.map do |contract_id|
      #@attendance_sheet.attendances.build(contract_id: contract_id)
    #end
  end

  # GET /attendance_sheets/1/edit
  def edit
  end

=begin
  # POST /attendance_sheets
  # POST /attendance_sheets.json
  def create
    @attendance_sheet = AttendanceSheet.new(attendance_sheet_params)

    respond_to do |format|
      if @attendance_sheet.save
        format.html { redirect_to @attendance_sheet, notice: 'Attendance sheet was successfully created.' }
        format.json { render :show, status: :created, location: @attendance_sheet }
      else
        format.html { render :new }
        format.json { render json: @attendance_sheet.errors, status: :unprocessable_entity }
      end
    end
  end
=end

  # POST /attendance_sheets
  # POST /attendance_sheets.json
  def create
    @group = Group.find(params["attendance_sheet"][:group_id])

    #@attendance_sheet = AttendanceSheet.new(attendance_sheet_params)
    @attendance_sheet = @group.attendance_sheets.new(attendance_sheet_params)



    respond_to do |format|
      if @attendance_sheet.save

        params["attendance_sheet"]["attendances_attributes"].each do |k, v|
          @contr_id = v["contract_id"]
          @lesson_1 = (v["lesson_1"] == "1") ? false : true
          @lesson_2 = (v["lesson_2"] == "1") ? false : true
          @lesson_3 = (v["lesson_3"] == "1") ? false : true
          @att_notes = v["attendanceNotes"]
          @att_sheet_id = @attendance_sheet.id

          Attendance.create(:contract_id => @contr_id, :attendance_sheet_id => @att_sheet_id, :lesson_1 => @lesson_1, :lesson_2 => @lesson_2, :lesson_3 => @lesson_3, :is_sent => false, :attendanceNotes => @att_notes)
        end

        format.html { redirect_to @attendance_sheet, notice: 'Topar Gatnaşygy Üstünlikli Ýazyldy.' }
        format.json { render :show, status: :created, location: @attendance_sheet }
      else
        format.html { render :new }
        format.json { render json: @attendance_sheet.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /attendance_sheets/1
  # PATCH/PUT /attendance_sheets/1.json
  def update
    respond_to do |format|
      if @attendance_sheet.update(attendance_sheet_params)

        params["attendance_sheet"]["attendances_attributes"].each do |k, v|
          @contr_id = v["contract_id"]
          @lesson_1 = (v["lesson_1"] == "1") ? false : true
          @lesson_2 = (v["lesson_2"] == "1") ? false : true
          @lesson_3 = (v["lesson_3"] == "1") ? false : true
          @att_notes = v["attendanceNotes"]
          @att_sheet_id = @attendance_sheet.id

          Attendance.find_by_contract_id_and_attendance_sheet_id(@contr_id, @att_sheet_id).update(:lesson_1 => @lesson_1, :lesson_2 => @lesson_2, :lesson_3 => @lesson_3,:attendanceNotes => @att_notes)
        end


        format.html { redirect_to @attendance_sheet, notice: 'Topar Gatnaşygy Üstünlikli Üýtgedildi.' }
        format.json { render :show, status: :ok, location: @attendance_sheet }
      else
        format.html { render :edit }
        format.json { render json: @attendance_sheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attendance_sheets/1
  # DELETE /attendance_sheets/1.json
  def destroy
    @attendance_sheet.destroy
    respond_to do |format|
      format.html { redirect_to attendance_sheets_url, notice: 'Topar Gatnaşygy Üstünlikli Bozuldy.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendance_sheet
      @attendance_sheet = AttendanceSheet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attendance_sheet_params
      #params.require(:attendance_sheet).permit(:group_id, :attendanceSheetDate, :attendanceSheetNotes, attendances_attributes: [:contract_id, :attendanceSheet_id, :attendanceList, :attendanceNotes])
      params.require(:attendance_sheet).permit(:group_id, :attendanceSheetDate, :attendanceSheetNotes)
    end
end
