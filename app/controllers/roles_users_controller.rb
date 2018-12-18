class RolesUsersController < ApplicationController
  before_action :set_roles_user, only: [:show, :edit, :update, :destroy]
  before_action 'check_access', only: [:index, :show, :new, :edit, :destroy]

  # GET /roles_users
  # GET /roles_users.json
  def index
    @roles_users = RolesUser.all
  end

  # GET /roles_users/1
  # GET /roles_users/1.json
  def show
  end

  # GET /roles_users/new
  def new
    @roles_user = RolesUser.new
  end

  # GET /roles_users/1/edit
  def edit
  end

  # POST /roles_users
  # POST /roles_users.json
  def create
    @roles_user = RolesUser.new(roles_user_params)

    respond_to do |format|
      if @roles_user.save
        format.html { redirect_to @roles_user, notice: 'Roles user was successfully created.' }
        format.json { render :show, status: :created, location: @roles_user }
      else
        format.html { render :new }
        format.json { render json: @roles_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /roles_users/1
  # PATCH/PUT /roles_users/1.json
  def update
    respond_to do |format|
      if @roles_user.update(roles_user_params)
        format.html { redirect_to @roles_user, notice: 'Roles user was successfully updated.' }
        format.json { render :show, status: :ok, location: @roles_user }
      else
        format.html { render :edit }
        format.json { render json: @roles_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles_users/1
  # DELETE /roles_users/1.json
  def destroy
    @roles_user.destroy
    respond_to do |format|
      format.html { redirect_to roles_users_url, notice: 'Roles user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_roles_user
      @roles_user = RolesUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def roles_user_params
      params.require(:roles_user).permit(:role_id, :user_id)
    end
end
