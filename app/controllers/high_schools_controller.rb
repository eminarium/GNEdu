class HighSchoolsController < ApplicationController
  before_action :set_high_school, only: [:show, :edit, :update, :destroy]
  before_action 'check_access', only: [:index, :show, :new, :edit, :destroy]

  # GET /high_schools
  # GET /high_schools.json
  def index
    @high_schools = HighSchool.all
  end

  # GET /high_schools/1
  # GET /high_schools/1.json
  def show
  end

  # GET /high_schools/new
  def new
    @high_school = HighSchool.new
  end

  # GET /high_schools/1/edit
  def edit
  end

  # POST /high_schools
  # POST /high_schools.json
  def create
    @high_school = HighSchool.new(high_school_params)

    respond_to do |format|
      if @high_school.save
        format.html { redirect_to @high_school, notice: 'High school was successfully created.' }
        format.json { render :show, status: :created, location: @high_school }
      else
        format.html { render :new }
        format.json { render json: @high_school.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /high_schools/1
  # PATCH/PUT /high_schools/1.json
  def update
    respond_to do |format|
      if @high_school.update(high_school_params)
        format.html { redirect_to @high_school, notice: 'High school was successfully updated.' }
        format.json { render :show, status: :ok, location: @high_school }
      else
        format.html { render :edit }
        format.json { render json: @high_school.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /high_schools/1
  # DELETE /high_schools/1.json
  def destroy
    @high_school.destroy
    respond_to do |format|
      format.html { redirect_to high_schools_url, notice: 'High school was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_high_school
      @high_school = HighSchool.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def high_school_params
      params.require(:high_school).permit(:highSchoolName, :notes)
    end
end
