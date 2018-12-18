class BookLanguagesController < ApplicationController
  before_action :set_book_language, only: [:show, :edit, :update, :destroy]
  before_action 'check_access', only: [:index, :show, :new, :edit, :destroy]

  # GET /book_languages
  # GET /book_languages.json
  def index
    @book_languages = BookLanguage.all
  end

  # GET /book_languages/1
  # GET /book_languages/1.json
  def show
  end

  # GET /book_languages/new
  def new
    @book_language = BookLanguage.new
  end

  # GET /book_languages/1/edit
  def edit
  end

  # POST /book_languages
  # POST /book_languages.json
  def create
    @book_language = BookLanguage.new(book_language_params)

    respond_to do |format|
      if @book_language.save
        format.html { redirect_to @book_language, notice: 'Book language was successfully created.' }
        format.json { render :show, status: :created, location: @book_language }
      else
        format.html { render :new }
        format.json { render json: @book_language.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /book_languages/1
  # PATCH/PUT /book_languages/1.json
  def update
    respond_to do |format|
      if @book_language.update(book_language_params)
        format.html { redirect_to @book_language, notice: 'Book language was successfully updated.' }
        format.json { render :show, status: :ok, location: @book_language }
      else
        format.html { render :edit }
        format.json { render json: @book_language.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /book_languages/1
  # DELETE /book_languages/1.json
  def destroy
    @book_language.destroy
    respond_to do |format|
      format.html { redirect_to book_languages_url, notice: 'Book language was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book_language
      @book_language = BookLanguage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_language_params
      params.require(:book_language).permit(:bookLanguageFullName, :bookLanguageShortName, :notes)
    end
end
