class FinalsController < ApplicationController
  before_action :set_final, only: [:show, :edit, :update, :destroy]
  before_action 'check_access', only: [:index, :show, :new, :edit, :destroy, :submit, :submitted]

  # GET /finals
  # GET /finals.json
  def index
    @finals = Final.where(:season_id => session[:active_season_id])
  end

  # GET /finals
  # GET /finals.json
  def submit
    #@finals = Final.all
  end

  def submitted
    #if (params[:midtermOrderNo].blank?)
    if (!params[:fileUrl].blank?)
      @xlsx = Roo::Spreadsheet.open("D:\\"+params[:fileUrl].to_s)
      @xlsx.default_sheet = @xlsx.sheets.first
    end


    #@xlsx = Excel.new('D:\\'+params[:fileUrl].to_s)


    @saved_finals = 0
    @failed_finals = 0


    @res = ""

    if (!@xlsx.nil? )

      ((@xlsx.first_row + 1)..@xlsx.last_row).each do |row|
        #@res = @res + 'contract_id ' + @sheet.cell(line, 'A').to_s + '<br>'
        #@res = @res + 'isReleasedFrom ' + @sheet.cell(line, 'B').to_s + '<br>'
        #@res = @res + 'midtermPoints ' + @sheet.cell(line, 'C').to_s + '<br>'
        #@res = @res + 'midtermNotes ' + @sheet.cell(line, 'D').to_s + '<br>'

        #@res = 'midtermNotes ' + @xlsx.cell(row, 'B').to_s + '<br>'

        @contract_id = @xlsx.cell(row,'D')
        @finalPoints = @xlsx.cell(row, 'F')
        @finalNotes = @xlsx.cell(row, 'E')
        #@res = @res + '<br>'.html_safe + @contract_id.to_s + ' ' + @midtermOrderNo.to_s + ' ' + @midtermPoints.to_s + ' ' + @isReleasedFrom.to_s + ' ' + @midtermNotes.to_s

        @final = Final.new()

        @final.contract_id = @contract_id
        @final.finalPoints = @finalPoints
        @final.season_id = session[:active_season_id]
        @final.finalNotes = @finalNotes

        if (Final.where(:contract_id => @contract_id).count>0)
          @failed_finals = @failed_finals+1  # Öň bar bolan we gaýtadan girizilmeýän arasynaglaryň mukdaryny sanaýarys.
        else
          @final.save!
          @saved_finals = @saved_finals +1   # Öň bazada bolmadyk we täze girizilýän arasynaglaryň mukdaryny sanaýarys.
        end

      end

      @final_file_results = "<div class='alert alert-success' style='font-size:12pt'>".html_safe+@xlsx.info+"</div>".html_safe        # Arasynag faýly görkezilen we tapylan bolsa ol barada maglumat görkezmeli

    else
      @final_file_results = "<div class='alert alert-danger' style='font-size:12pt'>".html_safe+'Faýl tapylmady ýa-da arasynag tertip belgisi girizilmedi !'+"</div>".html_safe  # Arasynag faýly tapylmadyk ýa-da görkezilmedik bolsa şeýle habarnama çykarmaly.
    end

  end


  # GET /finals/1
  # GET /finals/1.json
  def show
  end

  # GET /finals/new
  def new
    @final = Final.new
  end

  # GET /finals/1/edit
  def edit
  end

  # POST /finals
  # POST /finals.json
  def create
    @final = Final.new(final_params)

    respond_to do |format|
      if @final.save
        format.html { redirect_to @final, notice: 'Final was successfully created.' }
        format.json { render :show, status: :created, location: @final }
      else
        format.html { render :new }
        format.json { render json: @final.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /finals/1
  # PATCH/PUT /finals/1.json
  def update
    respond_to do |format|
      if @final.update(final_params)
        format.html { redirect_to @final, notice: 'Final was successfully updated.' }
        format.json { render :show, status: :ok, location: @final }
      else
        format.html { render :edit }
        format.json { render json: @final.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /finals/1
  # DELETE /finals/1.json
  def destroy
    @final.destroy
    respond_to do |format|
      format.html { redirect_to finals_url, notice: 'Final was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_final
      @final = Final.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def final_params
      params.require(:final).permit(:contract_id, :finalPoints, :season_id, :finalNotes)
    end
end
