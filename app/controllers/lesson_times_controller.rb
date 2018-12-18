class LessonTimesController < ApplicationController
  before_action :set_lesson_time, only: [:show, :edit, :update, :destroy]
  before_action 'check_access', only: [:index, :show, :new, :edit, :destroy]

  # GET /lesson_times
  # GET /lesson_times.json
  def index
    @lesson_times = LessonTime.all
  end

  # GET /lesson_times/1
  # GET /lesson_times/1.json
  def show
  end

  # GET /lesson_times/new
  def new
    @lesson_time = LessonTime.new
  end

  # GET /lesson_times/1/edit
  def edit
  end

  # POST /lesson_times
  # POST /lesson_times.json
  def create
    @lesson_time = LessonTime.new(lesson_time_params)

    respond_to do |format|
      if @lesson_time.save
        format.html { redirect_to @lesson_time, notice: 'Lesson time was successfully created.' }
        format.json { render :show, status: :created, location: @lesson_time }
      else
        format.html { render :new }
        format.json { render json: @lesson_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lesson_times/1
  # PATCH/PUT /lesson_times/1.json
  def update
    respond_to do |format|
      if @lesson_time.update(lesson_time_params)
        format.html { redirect_to @lesson_time, notice: 'Lesson time was successfully updated.' }
        format.json { render :show, status: :ok, location: @lesson_time }
      else
        format.html { render :edit }
        format.json { render json: @lesson_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lesson_times/1
  # DELETE /lesson_times/1.json
  def destroy
    @lesson_time.destroy
    respond_to do |format|
      format.html { redirect_to lesson_times_url, notice: 'Lesson time was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson_time
      @lesson_time = LessonTime.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lesson_time_params
      params.require(:lesson_time).permit(:lessonTimeTitle, :lessonTimeFrom, :lessonTimeTo, :notes)
    end
end
