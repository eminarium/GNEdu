class SubjectCategoriesController < ApplicationController
  before_action :set_subject_category, only: [:show, :edit, :update, :destroy]
  before_action 'check_access', only: [:index, :show, :new, :edit, :destroy]

  # GET /subject_categories
  # GET /subject_categories.json
  def index
    @subject_categories = SubjectCategory.all
  end

  # GET /subject_categories/1
  # GET /subject_categories/1.json
  def show
  end

  # GET /subject_categories/new
  def new
    @subject_category = SubjectCategory.new
  end

  # GET /subject_categories/1/edit
  def edit
  end

  # POST /subject_categories
  # POST /subject_categories.json
  def create
    @subject_category = SubjectCategory.new(subject_category_params)

    respond_to do |format|
      if @subject_category.save
        format.html { redirect_to @subject_category, notice: 'Subject category was successfully created.' }
        format.json { render :show, status: :created, location: @subject_category }
      else
        format.html { render :new }
        format.json { render json: @subject_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subject_categories/1
  # PATCH/PUT /subject_categories/1.json
  def update
    respond_to do |format|
      if @subject_category.update(subject_category_params)
        format.html { redirect_to @subject_category, notice: 'Subject category was successfully updated.' }
        format.json { render :show, status: :ok, location: @subject_category }
      else
        format.html { render :edit }
        format.json { render json: @subject_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subject_categories/1
  # DELETE /subject_categories/1.json
  def destroy
    @subject_category.destroy
    respond_to do |format|
      format.html { redirect_to subject_categories_url, notice: 'Subject category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject_category
      @subject_category = SubjectCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subject_category_params
      params.require(:subject_category).permit(:subjectCategoryFullName, :subjectCategoryShortName, :subject_code, :notes)
    end
end
