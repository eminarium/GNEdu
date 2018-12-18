class GroupGendersController < ApplicationController
  before_action :set_group_gender, only: [:show, :edit, :update, :destroy]
  before_action 'check_access', only: [:index, :show, :new, :edit, :destroy]

  # GET /group_genders
  # GET /group_genders.json
  def index
    @group_genders = GroupGender.all
  end

  # GET /group_genders/1
  # GET /group_genders/1.json
  def show
  end

  # GET /group_genders/new
  def new
    @group_gender = GroupGender.new
  end

  # GET /group_genders/1/edit
  def edit
  end

  # POST /group_genders
  # POST /group_genders.json
  def create
    @group_gender = GroupGender.new(group_gender_params)

    respond_to do |format|
      if @group_gender.save
        format.html { redirect_to @group_gender, notice: 'Group gender was successfully created.' }
        format.json { render :show, status: :created, location: @group_gender }
      else
        format.html { render :new }
        format.json { render json: @group_gender.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /group_genders/1
  # PATCH/PUT /group_genders/1.json
  def update
    respond_to do |format|
      if @group_gender.update(group_gender_params)
        format.html { redirect_to @group_gender, notice: 'Group gender was successfully updated.' }
        format.json { render :show, status: :ok, location: @group_gender }
      else
        format.html { render :edit }
        format.json { render json: @group_gender.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_genders/1
  # DELETE /group_genders/1.json
  def destroy
    @group_gender.destroy
    respond_to do |format|
      format.html { redirect_to group_genders_url, notice: 'Group gender was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_gender
      @group_gender = GroupGender.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_gender_params
      params.require(:group_gender).permit(:groupGenderFullName, :groupGenderShortName, :notes)
    end
end
