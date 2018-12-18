class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :edit_profile, :update_profile, :destroy]
  before_action 'check_access', only: [:index, :show, :new, :edit, :destroy, :edit_profile]


  access_control do
    #allow logged_in, :except => :destroy
    #allow :owner, :of => :color, :to => [:edit, :destroy]
    #allow :admin
    allow all
    #allow logged_in, :except => :destroy
    #allow anonymous, :to => [:index, :show]
  end

  # GET /users
  # GET /users.json
  def index
    @all_users = User.all.order(:userLogin)
    @unblocked_users = @all_users.where(:isBlocked => false).order(:userLogin)
    @blocked_users = @all_users.where(:isBlocked => true).order(:userLogin)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    @roles = Role.order(:name).all;
    #@roles = Role.all
  end

  # GET /users/1/edit
  def edit
    @roles = Role.order(:name).all
    #@roles = Role.all
  end

  # GET /users/1/edit_profile
  def edit_profile
    if (@user != current_user )
      render 'layouts/restricted', :layout => 'nosidebar'
    end

    @user = current_user
    @roles = Role.order(:name).all
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update_profile

    @roles = Role.order(:name).all

    if params[:user][:avatar_url]
      uploaded_io = params[:user][:avatar_url]
      File.open(Rails.root.join('public', 'uploads/avatars/', @user.id.to_s+".jpg"), 'wb') do |file|
        file.write(uploaded_io.read)
      end

      params[:user][:avatar_url] = @user.id.to_s+".jpg"
    end

    respond_to do |format|
      if @user.update(user_params)

        if (current_user.role.name == "examinator")
          format.html { redirect_to welcome_examinator_url }
        elsif (current_user.role.name == "observer")
          format.html { redirect_to welcome_observer_url }
        elsif (current_user.role.name == "librarian")

          if (Season.where("\"seasonFromDate\" <= ? AND \"seasonToDate\" >= ?", DateTime.now, DateTime.now).empty?)
            session[:active_season_id] = Season.find_by_id(session[:active_season_id]).id
          else
            session[:active_season_id] = Season.where("\"seasonFromDate\" <= ? AND \"seasonToDate\" >= ?", DateTime.now, DateTime.now).first.id
            @ongoing_season = Season.find_by_id(@ongoing_season_id)
          end

          format.html { redirect_to welcome_librarian_url }

        elsif (current_user.role.name == "registrar")
          format.html { redirect_to welcome_registrar_url }
        elsif (current_user.role.name == "admin")
          format.html { redirect_to welcome_admin_url }
        elsif (current_user.role.name == "teacher")

          if (Season.where("\"seasonFromDate\" <= ? AND \"seasonToDate\" >= ?", DateTime.now, DateTime.now).empty?)
            session[:active_season_id] = Season.find_by_id(session[:active_season_id]).id
          else
            session[:active_season_id] = Season.where("\"seasonFromDate\" <= ? AND \"seasonToDate\" >= ?", DateTime.now, DateTime.now).first.id
            @ongoing_season = Season.find_by_id(@ongoing_season_id)
          end
          format.html { redirect_to welcome_teacher_url }

        else
          format.html { redirect_to subjects_url }
          format.json { render :show, status: :created, location: @user_session }
        end
=begin
        if (@user.role.name == )
        format.html { redirect_to :welcome_admin, notice: 'Ulanyjy Maglumatlary Üstünlikli Üýtgedildi !' }
        #format.json { render :welcome_admin, status: :ok, location: :welcome_admin }
      else
        format.html { render :edit_profile }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
=end
    end
    end
  end


  # POST /users
  # POST /users.json
  def create

    @roles = Role.order(:name).all;
    uploaded_io = params[:user][:avatar_url]
    @next_max_user_id = User.maximum(:id)+1

    if uploaded_io
      File.open(Rails.root.join('public', 'uploads/avatars/', @next_max_user_id.to_s+".jpg"), 'wb') do |file|
        file.write(uploaded_io.read)
      end

      params[:user][:avatar_url] = @next_max_user_id.to_s+".jpg"
    else
      params[:user][:avatar_url] = ""
    end



    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'Täze Ulanyjy Üstünlikli Goşuldy !' }
        #@user.has_role!(params[:role_id])                             # assign a new role
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update

    @roles = Role.order(:name).all;

    if params[:user][:avatar_url]
      uploaded_io = params[:user][:avatar_url]
      File.open(Rails.root.join('public', 'uploads/avatars/', @user.id.to_s+".jpg"), 'wb') do |file|
        file.write(uploaded_io.read)
      end

      params[:user][:avatar_url] = @user.id.to_s+".jpg"
    end

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Ulanyjy Maglumatlary Üstünlikli Üýtgedildi !' }
        #@user.has_role!(params[:role_id])                             # assign a new role
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:userLogin, :userFName, :userLName, :avatar_url, :password, :password_confirmation, :persistence_token, :role_id, :isBlocked, :notes)
    end
end
