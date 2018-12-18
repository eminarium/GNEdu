class AnnouncementsController < ApplicationController
  before_action :set_announcement, only: [:show, :edit, :update, :destroy]
  #before_action 'check_access', only: [:index, :show, :new, :edit, :destroy]

  # GET /announcements
  # GET /announcements.json
  def index
    @announcements = Announcement.where(:season_id => session[:active_season_id])
    @seasons = Season.all
  end

  # GET /announcements/1
  # GET /announcements/1.json
  def show
    if (AnnouncementsUser.find_by_user_id_and_announcement_id(current_user.id, @announcement.id).blank?)
      AnnouncementsUser.create(:user_id => current_user.id, :announcement_id => @announcement.id, :created_at => Date.today())
    end
  end

  # GET /announcements/new
  def new
    @announcement = Announcement.new
    @seasons = Season.all

    @announcement.season_id = session[:active_season_id]
  end

  # GET /announcements/1/edit
  def edit
    @seasons = Season.all
    end

  # POST /announcements
  # POST /announcements.json
  def create
    @announcement = Announcement.new(announcement_params)

    respond_to do |format|
      if @announcement.save
        format.html { redirect_to @announcement, notice: 'Announcement was successfully created.' }
        format.json { render :show, status: :created, location: @announcement }
      else
        format.html { render :new }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /announcements/1
  # PATCH/PUT /announcements/1.json
  def update
    respond_to do |format|
      if @announcement.update(announcement_params)
        format.html { redirect_to @announcement, notice: 'Announcement was successfully updated.' }
        format.json { render :show, status: :ok, location: @announcement }
      else
        format.html { render :edit }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /announcements/1
  # DELETE /announcements/1.json
  def destroy
    @announcement.destroy
    respond_to do |format|
      format.html { redirect_to announcements_url, notice: 'Announcement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_announcement
      @announcement = Announcement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def announcement_params
      params.require(:announcement).permit(:announcementSubject, :announcementBody, :season_id)
    end
end
