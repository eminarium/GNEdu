class NationalitiesController < ApplicationController
  before_action :set_nationality, only: [:show, :edit, :update, :destroy]
  before_action 'check_access', only: [:index, :show, :new, :edit, :destroy]

  # GET /nationalities
  # GET /nationalities.json
  def index
    @nationalities = Nationality.all
  end

  # GET /nationalities/1
  # GET /nationalities/1.json
  def show
  end

  # GET /nationalities/new
  def new
    @nationality = Nationality.new
  end

  # GET /nationalities/1/edit
  def edit
  end

  # POST /nationalities
  # POST /nationalities.json
  def create
    @nationality = Nationality.new(nationality_params)

    respond_to do |format|
      if @nationality.save
        format.html { redirect_to @nationality, notice: 'Nationality was successfully created.' }
        format.json { render :show, status: :created, location: @nationality }
      else
        format.html { render :new }
        format.json { render json: @nationality.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nationalities/1
  # PATCH/PUT /nationalities/1.json
  def update
    respond_to do |format|
      if @nationality.update(nationality_params)
        format.html { redirect_to @nationality, notice: 'Nationality was successfully updated.' }
        format.json { render :show, status: :ok, location: @nationality }
      else
        format.html { render :edit }
        format.json { render json: @nationality.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nationalities/1
  # DELETE /nationalities/1.json
  def destroy
    @nationality.destroy
    respond_to do |format|
      format.html { redirect_to nationalities_url, notice: 'Nationality was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nationality
      @nationality = Nationality.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def nationality_params
      params.require(:nationality).permit(:nationalityName, :notes)
    end
end
