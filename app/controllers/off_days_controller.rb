class OffDaysController < ApplicationController
  before_action :set_off_day, only: [:show, :edit, :update, :destroy]
  before_action 'check_access', only: [:index, :show, :new, :edit, :destroy]

  # GET /off_days
  # GET /off_days.json
  def index
    @off_days = OffDay.all
  end

  # GET /off_days/1
  # GET /off_days/1.json
  def show
  end

  # GET /off_days/new
  def new
    @off_day = OffDay.new
  end

  # GET /off_days/1/edit
  def edit
  end

  # POST /off_days
  # POST /off_days.json
  def create
    @off_day = OffDay.new(off_day_params)

    respond_to do |format|
      if @off_day.save
        format.html { redirect_to @off_day, notice: 'Off day was successfully created.' }
        format.json { render :show, status: :created, location: @off_day }
      else
        format.html { render :new }
        format.json { render json: @off_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /off_days/1
  # PATCH/PUT /off_days/1.json
  def update
    respond_to do |format|
      if @off_day.update(off_day_params)
        format.html { redirect_to @off_day, notice: 'Off day was successfully updated.' }
        format.json { render :show, status: :ok, location: @off_day }
      else
        format.html { render :edit }
        format.json { render json: @off_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /off_days/1
  # DELETE /off_days/1.json
  def destroy
    @off_day.destroy
    respond_to do |format|
      format.html { redirect_to off_days_url, notice: 'Off day was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_off_day
      @off_day = OffDay.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def off_day_params
      params.require(:off_day).permit(:off_day_title, :off_day_date, :is_annual, :notes)
    end
end
