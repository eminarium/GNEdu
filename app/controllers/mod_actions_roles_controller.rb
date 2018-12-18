class ModActionsRolesController < ApplicationController
  before_action :set_mod_actions_role, only: [:show, :edit, :update, :destroy]
  before_action 'check_access', only: [:index, :show, :new, :edit, :destroy]

  # GET /mod_actions_roles
  # GET /mod_actions_roles.json
  def index
    @mod_actions_roles = ModActionsRole.all
  end

  # GET /mod_actions_roles/1
  # GET /mod_actions_roles/1.json
  def show
  end

  # GET /mod_actions_roles/new
  def new
    @mod_actions_role = ModActionsRole.new

    @roles = Role.all
    @mod_actions = ModAction.all
  end

  # GET /mod_actions_roles/1/edit
  def edit
    @roles = Role.all
    @mod_actions = ModAction.all
  end

  # POST /mod_actions_roles
  # POST /mod_actions_roles.json
  def create
    @mod_actions_role = ModActionsRole.new(mod_actions_role_params)

    respond_to do |format|
      if @mod_actions_role.save
        format.html { redirect_to @mod_actions_role, notice: 'Mod actions role was successfully created.' }
        format.json { render :show, status: :created, location: @mod_actions_role }
      else
        format.html { render :new }
        format.json { render json: @mod_actions_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mod_actions_roles/1
  # PATCH/PUT /mod_actions_roles/1.json
  def update
    respond_to do |format|
      if @mod_actions_role.update(mod_actions_role_params)
        format.html { redirect_to @mod_actions_role, notice: 'Mod actions role was successfully updated.' }
        format.json { render :show, status: :ok, location: @mod_actions_role }
      else
        format.html { render :edit }
        format.json { render json: @mod_actions_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mod_actions_roles/1
  # DELETE /mod_actions_roles/1.json
  def destroy
    @mod_actions_role.destroy
    respond_to do |format|
      format.html { redirect_to mod_actions_roles_url, notice: 'Mod actions role was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mod_actions_role
      @mod_actions_role = ModActionsRole.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mod_actions_role_params
      params.require(:mod_actions_role).permit(:role_id, :mod_action_id, :allowAccess, :auditTrack)
    end
end
