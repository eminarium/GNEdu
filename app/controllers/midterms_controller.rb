class MidtermsController < ApplicationController
  before_action :set_midterm, only: [:show, :edit, :update, :destroy]
  before_action 'check_access', only: [:index, :show, :new, :edit, :destroy, :submitted, :submit]

  # GET /midterms
  # GET /midterms.json
  def index
    #@this_season_contracts_ids = Contract.where(:season_id => session[:active_season_id]).select(:id)
    #@midterms = Midterm.where(:contract_id => @this_season_contracts_ids)

    @midterms = Midterm.where(:season_id => session[:active_season_id])
  end


  # GET /midterms
  # GET /midterms.json
  def submit
    #@midterms = Midterm.all
  end

  def submitted
    #if (params[:midtermOrderNo].blank?)
    if (!params[:fileUrl].blank?)
      @xlsx = Roo::Spreadsheet.open("D:\\"+params[:fileUrl].to_s)
      @xlsx.default_sheet = @xlsx.sheets.first
    end


    #@xlsx = Excel.new('D:\\'+params[:fileUrl].to_s)


    @saved_midterms = 0
    @failed_midterms = 0


    @res = ""

    if ((!@xlsx.nil?) && (!params[:midtermOrderNo].blank?))

      ((@xlsx.first_row + 1)..@xlsx.last_row).each do |row|

        @contract_id = @xlsx.cell(row,'D')
        @midtermOrderNo = params[:midtermOrderNo]
        @midtermPoints = @xlsx.cell(row, 'F')
        @isReleasedFrom = (@xlsx.cell(row, 'G') == 1) ? true : false
        @midtermNotes = @xlsx.cell(row, 'E')

        #@res = @res + '<br>'.html_safe + @contract_id.to_s + ' ' + @midtermOrderNo.to_s + ' ' + @midtermPoints.to_s + ' ' + @isReleasedFrom.to_s + ' ' + @midtermNotes.to_s

        @midterm = Midterm.new()

          @midterm.contract_id = @contract_id
          @midterm.midtermOrderNo = @midtermOrderNo
          @midterm.midtermPoints = @midtermPoints
          @midterm.isReleasedFrom = @isReleasedFrom
          @midterm.season_id = session[:active_season_id]
          @midterm.midtermNotes = @midtermNotes

        if (Midterm.where(:contract_id => @contract_id, :midtermOrderNo => @midtermOrderNo, :midtermPoints => @midtermPoints, :isReleasedFrom => @isReleasedFrom, :midtermNotes => @midtermNotes).count>0)
          @failed_midterms = @failed_midterms+1  # Öň bar bolan we gaýtadan girizilmeýän arasynaglaryň mukdaryny sanaýarys.
        else
          @midterm.save!
          @saved_midterms = @saved_midterms +1   # Öň bazada bolmadyk we täze girizilýän arasynaglaryň mukdaryny sanaýarys.
        end

      end

      @midterm_file_results = "<div class='alert alert-success' style='font-size:12pt'>".html_safe+@xlsx.info+"</div>".html_safe        # Arasynag faýly görkezilen we tapylan bolsa ol barada maglumat görkezmeli

    else
      @midterm_file_results = "<div class='alert alert-danger' style='font-size:12pt'>".html_safe+'Faýl tapylmady ýa-da arasynag tertip belgisi girizilmedi !'+"</div>".html_safe  # Arasynag faýly tapylmadyk ýa-da görkezilmedik bolsa şeýle habarnama çykarmaly.
    end

  end

  # GET /midterms/1
  # GET /midterms/1.json
  def show
  end


  # GET /midterms/new
  def new
    @midterm = Midterm.new
  end

  # GET /midterms/1/edit
  def edit
  end

  # POST /midterms
  # POST /midterms.json
  def create
    @midterm = Midterm.new(midterm_params)

    respond_to do |format|
      if @midterm.save
        format.html { redirect_to @midterm, notice: 'Midterm was successfully created.' }
        format.json { render :show, status: :created, location: @midterm }
      else
        format.html { render :new }
        format.json { render json: @midterm.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /midterms/1
  # PATCH/PUT /midterms/1.json
  def update
    respond_to do |format|
      if @midterm.update(midterm_params)
        format.html { redirect_to @midterm, notice: 'Midterm was successfully updated.' }
        format.json { render :show, status: :ok, location: @midterm }
      else
        format.html { render :edit }
        format.json { render json: @midterm.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /midterms/1
  # DELETE /midterms/1.json
  def destroy
    @midterm.destroy
    respond_to do |format|
      format.html { redirect_to midterms_url, notice: 'Midterm was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_midterm
      @midterm = Midterm.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def midterm_params
      params.require(:midterm).permit(:contract_id, :midtermOrderNo, :midtermPoints, :isReleasedFrom, :season_id, :midtermNotes)
    end
end
