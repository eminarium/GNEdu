class ModObjectsController < ApplicationController
  before_action :set_mod_object, only: [:show, :edit, :update, :destroy]
  before_action 'check_access', only: [:index, :show, :new, :edit, :destroy]

  # GET /mod_objects
  # GET /mod_objects.json
  def index
    @mod_objects = ModObject.all
  end

  # GET /mod_objects/1
  # GET /mod_objects/1.json
  def show
  end

  # GET /mod_objects/new
  def new
    @mod_object = ModObject.new
  end

  # GET /mod_objects/1/edit
  def edit
  end

  # POST /mod_objects
  # POST /mod_objects.json
  def create
    @mod_object = ModObject.new(mod_object_params)

    respond_to do |format|
      if @mod_object.save
        format.html { redirect_to @mod_object, notice: 'Mod object was successfully created.' }
        format.json { render :show, status: :created, location: @mod_object }
      else
        format.html { render :new }
        format.json { render json: @mod_object.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mod_objects/1
  # PATCH/PUT /mod_objects/1.json
  def update
    respond_to do |format|
      if @mod_object.update(mod_object_params)
        format.html { redirect_to @mod_object, notice: 'Mod object was successfully updated.' }
        format.json { render :show, status: :ok, location: @mod_object }
      else
        format.html { render :edit }
        format.json { render json: @mod_object.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mod_objects/1
  # DELETE /mod_objects/1.json
  def destroy
    @mod_object.destroy
    respond_to do |format|
      format.html { redirect_to mod_objects_url, notice: 'Mod object was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mod_object
      @mod_object = ModObject.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mod_object_params
      params.require(:mod_object).permit(:modObjectName, :modObjectTranslation, :description)
    end
end
