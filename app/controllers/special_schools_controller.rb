class SpecialSchoolsController < ApplicationController
  before_action :set_special_school, only: [:show, :edit, :update, :destroy]
  before_action 'check_access', only: [:index, :show, :new, :edit, :destroy]

  # GET /special_schools
  # GET /special_schools.json
  def index
    @special_schools = SpecialSchool.all
  end

  # GET /special_schools/1
  # GET /special_schools/1.json
  def show
  end

  # GET /special_schools/new
  def new
    @special_school = SpecialSchool.new
  end

  # GET /special_schools/1/edit
  def edit
  end

  # POST /special_schools
  # POST /special_schools.json
  def create
    @special_school = SpecialSchool.new(special_school_params)

    respond_to do |format|
      if @special_school.save
        format.html { redirect_to @special_school, notice: 'Special school was successfully created.' }
        format.json { render :show, status: :created, location: @special_school }
      else
        format.html { render :new }
        format.json { render json: @special_school.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /special_schools/1
  # PATCH/PUT /special_schools/1.json
  def update
    respond_to do |format|
      if @special_school.update(special_school_params)
        format.html { redirect_to @special_school, notice: 'Special school was successfully updated.' }
        format.json { render :show, status: :ok, location: @special_school }
      else
        format.html { render :edit }
        format.json { render json: @special_school.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /special_schools/1
  # DELETE /special_schools/1.json
  def destroy
    @special_school.destroy
    respond_to do |format|
      format.html { redirect_to special_schools_url, notice: 'Special school was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_special_school
      @special_school = SpecialSchool.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def special_school_params
      params.require(:special_school).permit(:specialSchoolName, :notes)
    end
end
