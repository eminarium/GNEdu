class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  before_action 'check_access', only: [:index, :show, :new, :edit, :destroy]

  # GET /notes
  # GET /notes.json
  def index
    @personal_notes = Note.where(:user_id => current_user.id)
    @public_notes = Note.where(:isPublic => true).where.not(:user_id => current_user.id)
    @shared_notes = Note.where(:id => NotesUser.where(:user_id => current_user.id).select(:note_id))
    #@notes = Note.all
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
    #@tmp = params[:user_id]
    @sharedUsers = NotesUser.where(:note_id => @note.id)
  end

  # GET /notes/new
  def new
    @note = Note.new
    @users = User.all
    #@note.user_id = current_user.id
  end

  # GET /notes/1/edit
  def edit
    @users = User.all

    @sharedUsers = NotesUser.where(:note_id => @note.id)

    @tmp_array_of_user_ids = Array.new(NotesUser.where(:note_id => @note.id).select(:user_id).each{|el| el.user_id })

    @id_array = []
    @tmp_array_of_user_ids.each{|a| @id_array.push(a.user_id)}

  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id

    respond_to do |format|
      if @note.save

        if (!@note.isPublic)                              # Set sharing options if the note is not publicly shared
          params[:note][:user_id].each do |item|           # A block of code to set current note sharing options with other users
            if (!item.blank?)
              @NewNoteUser = NotesUser.new(:note_id => @note.id, :user_id => item)
              @NewNoteUser.save
            end
          end
        end

        format.html { redirect_to @note, notice: 'Note was successfully created.' }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)

        if (!@note.isPublic)                           # Set sharing options if the note is not publicly shared
          params[:note][:user_id].each do |item|       # A block of code to set current note sharing options with other users
            if (!item.blank? && !NotesUser.where(:note_id => @note.id, :user_id => item).exists?)
              @NewNoteUser = NotesUser.new(:note_id => @note.id, :user_id => item)
              @NewNoteUser.save
            end
          end
        end

        NotesUser.where(:note_id => @note.id).each do |item|    # A block of code to remove current note sharing options with other users
          if (NotesUser.where(:note_id => @note.id).where.not(:user_id => params[:note][:user_id]).exists?)
            NotesUser.where(:note_id => @note.id).where.not(:user_id => params[:note][:user_id]).each do |tmp|
              tmp.destroy
            end
          end
        end

        if (@note.isPublic)                              # If note is publicly shared remove all personal sharing options
          NotesUser.where(:note_id => @note.id).each do |tmp|
            tmp.destroy
          end
        end

        format.html { redirect_to @note, notice: "" }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    NotesUser.where(:note_id => @note.id).each do |nt| # destroy sharing links of this note
      nt.destroy
    end

    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url, notice: 'Note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:user_id, :noteSubject, :noteContent, :isPublic)
    end
end
