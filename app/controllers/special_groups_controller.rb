class SpecialGroupsController < ApplicationController
  before_action :set_special_group, only: [:show, :edit, :update, :destroy]
  before_action 'check_access', only: [:index, :show, :new, :edit, :destroy]

  # GET /special_groups
  # GET /special_groups.json
  def index
    @special_groups = SpecialGroup.all
  end

  # GET /special_groups/1
  # GET /special_groups/1.json
  def show
  end

  # GET /special_groups/new
  def new
    @special_group = SpecialGroup.new

    @seasons = Season.all.order(:seasonTitle)
    @special_group.season_id = Season.active_season.id

  end

  # GET /special_groups/1/edit
  def edit
    @seasons = Season.all.order(:seasonTitle)
    #@special_group.season_id = Season.active_season.id
  end

  # POST /special_groups
  # POST /special_groups.json
  def create
    @special_group = SpecialGroup.new(special_group_params)

    respond_to do |format|
      if @special_group.save
        format.html { redirect_to @special_group, notice: 'Special group was successfully created.' }
        format.json { render :show, status: :created, location: @special_group }
      else
        format.html { render :new }
        format.json { render json: @special_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /special_groups/1
  # PATCH/PUT /special_groups/1.json
  def update
    respond_to do |format|
      if @special_group.update(special_group_params)
        format.html { redirect_to @special_group, notice: 'Special group was successfully updated.' }
        format.json { render :show, status: :ok, location: @special_group }
      else
        format.html { render :edit }
        format.json { render json: @special_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /special_groups/1
  # DELETE /special_groups/1.json
  def destroy
    @special_group.destroy
    respond_to do |format|
      format.html { redirect_to special_groups_url, notice: 'Special group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_special_group
      @special_group = SpecialGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def special_group_params
      params.require(:special_group).permit(:season_id, :specialGroupTitle, :notes)
    end
end
