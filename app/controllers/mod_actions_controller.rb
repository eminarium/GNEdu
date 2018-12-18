class ModActionsController < ApplicationController
  before_action :set_mod_action, only: [:show, :edit, :update, :destroy]
  before_action 'check_access', only: [:index, :show, :new, :edit, :destroy]

  # GET /mod_actions
  # GET /mod_actions.json
  def index
    @mod_actions = ModAction.all
  end

  # GET /mod_actions/1
  # GET /mod_actions/1.json
  def show
  end

  # GET /mod_actions/new
  def new
    @mod_objects = ModObject.all
    @roles = Role.all

    @mod_action = ModAction.new
  end

  # GET /mod_actions/1/edit
  def edit
    @mod_objects = ModObject.all
    @roles = Role.all
  end

  # POST /mod_actions
  # POST /mod_actions.json
  def create
    @mod_action = ModAction.new(mod_action_params)

    respond_to do |format|
      if @mod_action.save
        format.html { redirect_to @mod_action, notice: 'Mod action was successfully created.' }
        format.json { render :show, status: :created, location: @mod_action }
      else
        format.html { render :new }
        format.json { render json: @mod_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mod_actions/1
  # PATCH/PUT /mod_actions/1.json
  def update
    respond_to do |format|
      if @mod_action.update(mod_action_params)
        format.html { redirect_to @mod_action, notice: 'Mod action was successfully updated.' }
        format.json { render :show, status: :ok, location: @mod_action }
      else
        format.html { render :edit }
        format.json { render json: @mod_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mod_actions/1
  # DELETE /mod_actions/1.json
  def destroy
    @mod_action.destroy
    respond_to do |format|
      format.html { redirect_to mod_actions_url, notice: 'Mod action was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mod_action
      @mod_action = ModAction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mod_action_params
      params.require(:mod_action).permit(:mod_object_id, :modActionName, :description)
    end
end
