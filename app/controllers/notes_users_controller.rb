class NotesUsersController < ApplicationController
  before_action :set_notes_user, only: [:show, :edit, :update, :destroy]
  before_action 'check_access', only: [:index, :show, :new, :edit, :destroy]

  # GET /notes_users
  # GET /notes_users.json
  def index
    @notes_users = NotesUser.all
  end

  # GET /notes_users/1
  # GET /notes_users/1.json
  def show
  end

  # GET /notes_users/new
  def new
    @notes_user = NotesUser.new
  end

  # GET /notes_users/1/edit
  def edit
  end

  # POST /notes_users
  # POST /notes_users.json
  def create
    @notes_user = NotesUser.new(notes_user_params)

    respond_to do |format|
      if @notes_user.save
        format.html { redirect_to @notes_user, notice: 'Notes user was successfully created.' }
        format.json { render :show, status: :created, location: @notes_user }
      else
        format.html { render :new }
        format.json { render json: @notes_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes_users/1
  # PATCH/PUT /notes_users/1.json
  def update
    respond_to do |format|
      if @notes_user.update(notes_user_params)
        format.html { redirect_to @notes_user, notice: 'Notes user was successfully updated.' }
        format.json { render :show, status: :ok, location: @notes_user }
      else
        format.html { render :edit }
        format.json { render json: @notes_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes_users/1
  # DELETE /notes_users/1.json
  def destroy
    @notes_user.destroy
    respond_to do |format|
      format.html { redirect_to notes_users_url, notice: 'Notes user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notes_user
      @notes_user = NotesUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def notes_user_params
      params.require(:notes_user).permit(:note_id, :user_id)
    end
end
