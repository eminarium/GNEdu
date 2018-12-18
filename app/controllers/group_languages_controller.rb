class GroupLanguagesController < ApplicationController
  before_action :set_group_language, only: [:show, :edit, :update, :destroy]
  before_action 'check_access', only: [:index, :show, :new, :edit, :destroy]

  # GET /group_languages
  # GET /group_languages.json
  def index
    @group_languages = GroupLanguage.all
  end

  # GET /group_languages/1
  # GET /group_languages/1.json
  def show
  end

  # GET /group_languages/new
  def new
    @group_language = GroupLanguage.new
  end

  # GET /group_languages/1/edit
  def edit
  end

  # POST /group_languages
  # POST /group_languages.json
  def create
    @group_language = GroupLanguage.new(group_language_params)

    respond_to do |format|
      if @group_language.save
        format.html { redirect_to @group_language, notice: 'Group language was successfully created.' }
        format.json { render :show, status: :created, location: @group_language }
      else
        format.html { render :new }
        format.json { render json: @group_language.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /group_languages/1
  # PATCH/PUT /group_languages/1.json
  def update
    respond_to do |format|
      if @group_language.update(group_language_params)
        format.html { redirect_to @group_language, notice: 'Group language was successfully updated.' }
        format.json { render :show, status: :ok, location: @group_language }
      else
        format.html { render :edit }
        format.json { render json: @group_language.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_languages/1
  # DELETE /group_languages/1.json
  def destroy
    @group_language.destroy
    respond_to do |format|
      format.html { redirect_to group_languages_url, notice: 'Group language was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_language
      @group_language = GroupLanguage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_language_params
      params.require(:group_language).permit(:groupLanguageFullName, :groupLanguageShortName, :notes)
    end
end
