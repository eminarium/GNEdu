class ExamsController < ApplicationController
  before_action :set_exam, only: [:show, :edit, :update, :destroy]
  before_action 'check_access', only: [:index, :show, :new, :edit, :destroy]

  # GET /exams
  # GET /exams.json
  def index
    @exams = Exam.where(:season_id => session[:active_season_id])
  end

  # GET /exams/1
  # GET /exams/1.json
  def show
  end

  # GET /exams/new
  def new
    @exam = Exam.new
    @subjects = Subject.where.not(:subjectFullName => ['Türkçe-2', 'Rusça-2', 'Matematika-4', 'Computer-1', 'Computer-2', 'Computer-3', 'Computer-4', 'TOEFL', 'Computer-5', 'Computer-6']).order(:subject_category_id, :subjectLevel)
  end

  # GET /exams/1/edit
  def edit
    @subjects = Subject.where.not(:subjectFullName => ['Türkçe-2', 'Rusça-2', 'Matematika-4', 'Computer-1', 'Computer-2', 'Computer-3', 'Computer-4', 'TOEFL', 'Computer-5', 'Computer-6']).order(:subject_category_id, :subjectLevel)
  end

  # POST /exams
  # POST /exams.json
  def create

    uploaded_io = params[:exam][:persona_url]
    @next_max_ex_id = Exam.maximum(:id)+1

    if uploaded_io
      File.open(Rails.root.join('public', 'uploads/examinees/', @next_max_ex_id.to_s+".jpg"), 'wb') do |file|
        file.write(uploaded_io.read)
      end

      params[:exam][:persona_url] = @next_max_ex_id.to_s+".jpg"
    else
      params[:exam][:persona_url] = ""
    end

    @exam = Exam.new(exam_params)
    @subjects = Subject.where.not(:subjectFullName => ['Türkçe-2', 'Rusça-2', 'Matematika-4', 'Computer-1', 'Computer-2', 'Computer-3', 'Computer-4', 'TOEFL', 'Computer-5', 'Computer-6']).order(:subject_category_id, :subjectLevel)

    respond_to do |format|
      if @exam.save
        format.html { redirect_to @exam, notice: 'Exam was successfully created.' }
        format.json { render :show, status: :created, location: @exam }
      else
        format.html { render :new }
        format.json { render json: @exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exams/1
  # PATCH/PUT /exams/1.json
  def update
    @subjects = Subject.where.not(:subjectFullName => ['Türkçe-2', 'Rusça-2', 'Matematika-4', 'Computer-1', 'Computer-2', 'Computer-3', 'Computer-4', 'TOEFL']).order(:subject_category_id, :subjectLevel)

    if params[:exam][:persona_url]
      uploaded_io = params[:exam][:persona_url]
      File.open(Rails.root.join('public', 'uploads/examinees/', @exam.id.to_s+".jpg"), 'wb') do |file|
        file.write(uploaded_io.read)
      end

      params[:exam][:persona_url] = @exam.id.to_s+".jpg"
    end

    respond_to do |format|
      if @exam.update(exam_params)
        format.html { redirect_to @exam, notice: 'Exam was successfully updated.' }
        format.json { render :show, status: :ok, location: @exam }
      else
        format.html { render :edit }
        format.json { render json: @exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exams/1
  # DELETE /exams/1.json
  def destroy

    if (File.exist?(Rails.root.join('public', 'uploads/examinees/', @exam.persona_url.to_s)) && !@exam.persona_url.blank?)
      FileUtils.rm(Rails.root.join('public', 'uploads/examinees/', @exam.persona_url.to_s))
    end

    @exam.destroy
    respond_to do |format|
      format.html { redirect_to exams_url, notice: 'Exam was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exam
      @exam = Exam.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exam_params
      params.require(:exam).permit(:fName, :lName, :patronymic, :persona_url, :doc_serial, :doc_no, :subject_id, :season_id, :examDate, :examResult, :notes)
    end
end
