class BookLendsController < ApplicationController
  before_action :set_book_lend, only: [:show, :edit, :update, :destroy]
  before_action 'check_access', only: [:index, :show, :new, :edit, :destroy]

  # GET /book_lends
  # GET /book_lends.json
  def index
    @book_lends = BookLend.all
  end

  # GET /book_lends/1
  # GET /book_lends/1.json
  def show
  end

  # GET /book_lends/new
  def new
    @book_lend = BookLend.new
    @books = Book.all.order(:bookName)

    @season_students = Contract.where(:season_id => session[:active_season_id]).select(:student_id)
    @season_studs = Student.where(:id => @season_students)
  end

  # GET /book_lends/1/edit
  def edit
    @books = Book.all.order(:bookName)

    @selected_student = @book_lend.student_id
    @selected_book = @book_lend.book_id

    @season_students = Contract.where(:season_id => session[:active_season_id]).select(:student_id)
    @season_studs = Student.where(:id => @season_students)
  end

  # POST /book_lends
  # POST /book_lends.json
  def create
    @book_lend = BookLend.new(book_lend_params)

    respond_to do |format|
      if @book_lend.save

          if (!params[:book_lend][:student_id].blank?)
            @book_lend.student_id = params[:book_lend][:student_id]
            @book_lend.save
          end

        format.html { redirect_to @book_lend, notice: 'Book lend was successfully created.' }
        format.json { render :show, status: :created, location: @book_lend }
      else
        format.html { render :new }
        format.json { render json: @book_lend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /book_lends/1
  # PATCH/PUT /book_lends/1.json
  def update
    respond_to do |format|
      if @book_lend.update(book_lend_params)
        format.html { redirect_to @book_lend, notice: 'Book lend was successfully updated.' }
        format.json { render :show, status: :ok, location: @book_lend }
      else
        format.html { render :edit }
        format.json { render json: @book_lend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /book_lends/1
  # DELETE /book_lends/1.json
  def destroy
    @book_lend.destroy
    respond_to do |format|
      format.html { redirect_to book_lends_url, notice: 'Book lend was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book_lend
      @book_lend = BookLend.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_lend_params
      params.require(:book_lend).permit(:book_id, :student_id, :lendDateTime, :isReturned, :returnDateTime, :isDamaged, :notes)
    end
end
