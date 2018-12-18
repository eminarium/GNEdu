class ContestantBooksController < ApplicationController
  before_action :set_contestant_book, only: [:show, :edit, :update, :destroy]
  before_action 'check_access', only: [:index, :show, :new, :edit, :destroy]

  # GET /contestant_books
  # GET /contestant_books.json
  def index
    @contestant_books = ContestantBook.all
  end

  # GET /contestant_books/1
  # GET /contestant_books/1.json
  def show
  end

  # GET /contestant_books/new
  def new
    @contestant_book = ContestantBook.new
    @book_contests = BookContest.where(:season_id => session[:active_season_id])
    @books = Book.all
  end

  # GET /contestant_books/1/edit
  def edit
    @book_contests = BookContest.all
    @books = Book.all
  end

  # POST /contestant_books
  # POST /contestant_books.json
  def create
    @contestant_book = ContestantBook.new(contestant_book_params)

    respond_to do |format|
      if @contestant_book.save
        format.html { redirect_to @contestant_book, notice: 'Contestant book was successfully created.' }
        format.json { render :show, status: :created, location: @contestant_book }
      else
        format.html { render :new }
        format.json { render json: @contestant_book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contestant_books/1
  # PATCH/PUT /contestant_books/1.json
  def update
    respond_to do |format|
      if @contestant_book.update(contestant_book_params)
        format.html { redirect_to @contestant_book, notice: 'Contestant book was successfully updated.' }
        format.json { render :show, status: :ok, location: @contestant_book }
      else
        format.html { render :edit }
        format.json { render json: @contestant_book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contestant_books/1
  # DELETE /contestant_books/1.json
  def destroy
    @contestant_book.destroy
    respond_to do |format|
      format.html { redirect_to contestant_books_url, notice: 'Contestant book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contestant_book
      @contestant_book = ContestantBook.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contestant_book_params
      params.require(:contestant_book).permit(:book_id, :book_contest_id, :notes)
    end
end
