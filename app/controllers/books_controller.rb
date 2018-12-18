class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action 'check_access', only: [:index, :show, :new, :edit, :destroy, :search]

  # GET /books
  # GET /books.json
  def index
    @books = Book.all
  end


  def search
    if (params[:bookName].blank? )
      @books = Book.where(:bookName => "")
    else
      @books = Book.where(" lower(\"bookName\") LIKE ?", "%#{params[:bookName].mb_chars.downcase}%")
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
    @book_languages = BookLanguage.all.order(:bookLanguageShortName)
    @authors = Author.all
  end

  # GET /books/1/edit
  def edit
    @book_languages = BookLanguage.all.order(:bookLanguageShortName)

    @authors = Author.all

    @bookAuthors = AuthorsBook.where(:book_id => @book.id)

    @tmp_array_of_book_ids = Array.new(AuthorsBook.where(:book_id => @book.id).select(:author_id).each{|el| el.author_id })

    @id_array = []
    @tmp_array_of_book_ids.each{|a| @id_array.push(a.author_id)}
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save

        params[:book][:author_id].each do |item|           # A block of code to set current note sharing options with other users
          if (!item.blank?)
            @NewBookAuthor = AuthorsBook.new(:book_id => @book.id, :author_id => item)
            @NewBookAuthor.save
          end
        end

        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)

        params[:book][:author_id].each do |item|       # A block of code to set current note sharing options with other users
          if (!item.blank? && !AuthorsBook.where(:book_id => @book.id, :author_id => item).exists?)
            @NewBookAuthor = AuthorsBook.new(:book_id => @book.id, :author_id => item)
            @NewBookAuthor.save
          end
        end

        AuthorsBook.where(:book_id => @book.id).each do |item|    # A block of code to remove current note sharing options with other users
          if (AuthorsBook.where(:book_id => @book.id).where.not(:author_id => params[:book][:author_id]).exists?)
            AuthorsBook.where(:book_id => @book.id).where.not(:author_id => params[:book][:author_id]).each do |tmp|
              tmp.destroy
            end
          end
        end

        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    AuthorsBook.where(:book_id => @book.id).each do |ab| # destroy sharing links of this note
      ab.destroy
    end

    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:book_language_id, :bookName, :imageUrl, :totalQuantity, :notes)
    end
end
