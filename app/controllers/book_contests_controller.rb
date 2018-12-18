class BookContestsController < ApplicationController
  before_action :set_book_contest, only: [:show, :edit, :update, :destroy, :contest_info, :participants]
  before_action 'check_access', only: [:index, :show, :new, :edit, :destroy]

  # GET /book_contests
  # GET /book_contests.json
  def index
    @book_contests = BookContest.where(:season_id => session[:active_season_id]).order(:bookContestName)
  end

  # GET /book_contests/1
  # GET /book_contests/1.json
  def show
  end

  # GET /book_contests/1
  # GET /book_contests/1.json
  def participants
    @contest_registered_contracts = BookContestParticipant.where(:book_contest_id => @book_contest.id).includes(:contract, :book_language)
  end


  # GET /book_contests/1
  # GET /book_contests/1.json
  def contest_info
    @contest_registered_contracts = BookContestParticipant.where(:book_contest_id => @book_contest.id).select(:contract_id)
    @tkm_contest_registered_contracts = @contest_registered_contracts.where(:book_language_id => BookLanguage.find_by_bookLanguageShortName("TKM").id)
    @rus_contest_registered_contracts = @contest_registered_contracts.where(:book_language_id => BookLanguage.find_by_bookLanguageShortName("RUS").id)
    @eng_contest_registered_contracts = @contest_registered_contracts.where(:book_language_id => BookLanguage.find_by_bookLanguageShortName("ENG").id)
  end

  # GET /book_contests/new
  def new
    @book_contest = BookContest.new
    @seasons = Season.all.order(:seasonNo)

    @book_contest.season_id = session[:active_season_id]
  end

  # GET /book_contests/1/edit
  def edit
    @seasons = Season.all.order(:seasonNo)
  end

  # POST /book_contests
  # POST /book_contests.json
  def create
    @book_contest = BookContest.new(book_contest_params)

    respond_to do |format|
      if @book_contest.save
        format.html { redirect_to @book_contest, notice: 'Book contest was successfully created.' }
        format.json { render :show, status: :created, location: @book_contest }
      else
        format.html { render :new }
        format.json { render json: @book_contest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /book_contests/1
  # PATCH/PUT /book_contests/1.json
  def update
    respond_to do |format|
      if @book_contest.update(book_contest_params)
        format.html { redirect_to @book_contest, notice: 'Book contest was successfully updated.' }
        format.json { render :show, status: :ok, location: @book_contest }
      else
        format.html { render :edit }
        format.json { render json: @book_contest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /book_contests/1
  # DELETE /book_contests/1.json
  def destroy
    @book_contest.destroy
    respond_to do |format|
      format.html { redirect_to book_contests_url, notice: 'Book contest was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book_contest
      @book_contest = BookContest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_contest_params
      params.require(:book_contest).permit(:bookContestName, :season_id, :notes)
    end
end
