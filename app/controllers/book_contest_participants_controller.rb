class BookContestParticipantsController < ApplicationController
  before_action :set_book_contest_participant, only: [:show, :edit, :update, :destroy]
  before_action 'check_access', only: [:index, :show, :new, :edit, :destroy]

  # GET /book_contest_participants
  # GET /book_contest_participants.json
  def index
    @book_contest_participants = BookContestParticipant.all
  end

  # GET /book_contest_participants/1
  # GET /book_contest_participants/1.json
  def show
  end

  # GET /book_contest_participants/new
  def new
    @book_contest_participant = BookContestParticipant.new
    @book_contests = BookContest.where(:season_id => session[:active_season_id])
    @book_languages = BookLanguage.all
    #@contest_books = ContestantBook.where()
    @contracts = Contract.where(:season_id => session[:active_season_id])
    @contract_id = params[:contract_id]
  end

  # GET /book_contest_participants/1/edit
  def edit
    @book_contests = BookContest.where(:season_id => session[:active_season_id])
    @book_languages = BookLanguage.all
    @contracts = Contract.where(:season_id => session[:active_season_id])
    @contract_id = @book_contest_participant.id
  end

  # POST /book_contest_participants
  # POST /book_contest_participants.json
  def create
    @book_contest_participant = BookContestParticipant.new(book_contest_participant_params)

    respond_to do |format|
      if @book_contest_participant.save
        format.html { redirect_to @book_contest_participant, notice: 'Book contest participant was successfully created.' }
        format.json { render :show, status: :created, location: @book_contest_participant }
      else
        format.html { render :new }
        format.json { render json: @book_contest_participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /book_contest_participants/1/edit
  def book_contest_register
    @book_languages = BookLanguage.all
    @group_id = params[:gid]
    @current_group_contracts = Contract.where(:group_id => @group_id, :isMoneyReturned => false)

  end

  # PATCH/PUT /book_contest_participants/1
  # PATCH/PUT /book_contest_participants/1.json
  def update
    respond_to do |format|
      if @book_contest_participant.update(book_contest_participant_params)
        format.html { redirect_to @book_contest_participant, notice: 'Book contest participant was successfully updated.' }
        format.json { render :show, status: :ok, location: @book_contest_participant }
      else
        format.html { render :edit }
        format.json { render json: @book_contest_participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /book_contest_participants/1
  # DELETE /book_contest_participants/1.json
  def destroy
    @book_contest_participant.destroy
    respond_to do |format|
      format.html { redirect_to book_contest_participants_url, notice: 'Book contest participant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book_contest_participant
      @book_contest_participant = BookContestParticipant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_contest_participant_params
      params.require(:book_contest_participant).permit(:contract_id, :book_contest_id, :book_language_id, :notes)
    end
end
