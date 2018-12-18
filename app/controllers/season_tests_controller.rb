class SeasonTestsController < ApplicationController
  before_action :set_season_test, only: [:show, :edit, :update, :destroy]
  before_action 'check_access', only: [:index, :show, :new, :edit, :destroy]

  # GET /season_tests
  # GET /season_tests.json
  def index
    @season_tests = SeasonTest.where(:season_id => session[:active_season_id]).order(:seasonTestDate)
  end

  # GET /season_tests/1
  # GET /season_tests/1.json
  def show
  end

  # GET /season_tests/new
  def new
    @seasons = Season.all
    @season_test = SeasonTest.new
    @season_test.season_id = Season.where(:seasonNo=> Setting.where(:settingName => 'Aktiw_tapgyr')[0].settingValue)[0].id
  end

  # GET /season_tests/1/edit
  def edit
    @seasons = Season.all
    @season_test.season_id = Season.where(:seasonNo=> Setting.where(:settingName => 'Aktiw_tapgyr')[0].settingValue)[0].id
  end

  # POST /season_tests
  # POST /season_tests.json
  def create
    @season_test = SeasonTest.new(season_test_params)

    respond_to do |format|
      if @season_test.save
        format.html { redirect_to @season_test, notice: 'Season test was successfully created.' }
        format.json { render :show, status: :created, location: @season_test }
      else
        format.html { render :new }
        format.json { render json: @season_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /season_tests/1
  # PATCH/PUT /season_tests/1.json
  def update
    respond_to do |format|
      if @season_test.update(season_test_params)
        format.html { redirect_to @season_test, notice: 'Season test was successfully updated.' }
        format.json { render :show, status: :ok, location: @season_test }
      else
        format.html { render :edit }
        format.json { render json: @season_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /season_tests/1
  # DELETE /season_tests/1.json
  def destroy
    @season_test.destroy
    respond_to do |format|
      format.html { redirect_to season_tests_url, notice: 'Season test was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_season_test
      @season_test = SeasonTest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def season_test_params
      params.require(:season_test).permit(:season_id, :seasonTestTitle, :seasonTestDate, :isFinal, :seasonTestNotes)
    end
end
