class AuthorsBooksController < ApplicationController
  before_action :set_authors_book, only: [:show, :edit, :update, :destroy]
  before_action 'check_access', only: [:index, :show, :new, :edit, :destroy]

  # GET /authors_books
  # GET /authors_books.json
  def index
    @authors_books = AuthorsBook.all
  end

  # GET /authors_books/1
  # GET /authors_books/1.json
  def show
  end

  # GET /authors_books/new
  def new
    @authors_book = AuthorsBook.new
  end

  # GET /authors_books/1/edit
  def edit
  end

  # POST /authors_books
  # POST /authors_books.json
  def create
    @authors_book = AuthorsBook.new(authors_book_params)

    respond_to do |format|
      if @authors_book.save
        format.html { redirect_to @authors_book, notice: 'Authors book was successfully created.' }
        format.json { render :show, status: :created, location: @authors_book }
      else
        format.html { render :new }
        format.json { render json: @authors_book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /authors_books/1
  # PATCH/PUT /authors_books/1.json
  def update
    respond_to do |format|
      if @authors_book.update(authors_book_params)
        format.html { redirect_to @authors_book, notice: 'Authors book was successfully updated.' }
        format.json { render :show, status: :ok, location: @authors_book }
      else
        format.html { render :edit }
        format.json { render json: @authors_book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /authors_books/1
  # DELETE /authors_books/1.json
  def destroy
    @authors_book.destroy
    respond_to do |format|
      format.html { redirect_to authors_books_url, notice: 'Authors book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_authors_book
      @authors_book = AuthorsBook.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def authors_book_params
      params.require(:authors_book).permit(:book_id, :author_id)
    end
end
