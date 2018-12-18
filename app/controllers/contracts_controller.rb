class ContractsController < ApplicationController
  before_action :set_contract, only: [:show, :invoice, :content_ru, :content_tm, :edit, :att_report, :update, :destroy, :return_payment]
  before_action 'check_access', only: [:index, :show, :new, :edit, :destroy, :birthdays, :search, :mycontractssearch, :mycontractsreport, :att_report, :repeating, :reserve, :general_report, :photoless_report, :incorrect_phones_report, :discount_report, :agaly_report, :tgb_report, :invoice, :content_ru, :content_tm]

  #set caches_page :index
  # GET /contracts
  # GET /contracts.json
  def index
    #@contracts = Contract.all
    #@current_season_no = Setting.where(:settingName => 'Aktiw_tapgyr')[0].settingValue
    #@current_season_id = Season.where(:seasonNo=> @current_season_no)[0].id
    #@contracts = Contract.where(:season_id => @current_season[0]).order(:lessonTime_id)

    #@current_season_id = Season.where(:seasonNo=> Setting.where(:settingName => 'Aktiw_tapgyr')[0].settingValue)[0].id  # Get id of current season from Settings object
    @current_season_id = session[:active_season_id]

    @contracts_all = Contract.where(:season_id => @current_season_id).includes(:payment_type, :season, :group, :student, :discount).order(:seasonContractNo)                              # Get contracts list from current season

    @contracts_returned = @contracts_all.where(:isMoneyReturned => true)                        # Get contracts list from current season
    @contracts_reserved = @contracts_all.where(:isReserve => true)                              # Get contracts list from current season
    #@contracts = Contract.cached_contracts
  end

  # GET /students
  # GET /students.json
  def search
    @current_season_id = session[:active_season_id]
    @groups = Group.where(:season_id => @current_season_id).order(:groupTitle)
    @special_groups = SpecialGroup.where(:season_id => @current_season_id).order(:specialGroupTitle)
    @id_array = []

    if (!params[:fName].blank? || !params[:lName].blank? || !params[:patronymic].blank?)
      @tmp_array_of_student_ids = Array.new(Student.where("lower(\"fName\") LIKE ? and lower(\"lName\") LIKE ? and lower(patronymic) LIKE ?", "%#{params[:fName].mb_chars.downcase}%", "%#{params[:lName].mb_chars.downcase}%", "%#{params[:patronymic].mb_chars.downcase}%").select(:id).each{|el| el.id })
      @tmp_array_of_student_ids.each{|a| @id_array.push(a.id)}
    end

    if (!(@id_array.empty?) || !(params[:seasonContractNo].blank?) || (params[:group_id].to_i != 0) || (params[:special_group_id].to_i != 0))
      @contracts = Contract.where(:season_id => @current_season_id)
      @contracts = @contracts.where(:group_id => params[:group_id].to_i) if (params[:group_id].to_i != 0)
      @contracts = @contracts.where(:special_group_id => params[:special_group_id].to_i) if (params[:special_group_id].to_i != 0)
      @contracts = @contracts.where(:seasonContractNo => params[:seasonContractNo]) if (!params[:seasonContractNo].blank?)
      @contracts = @contracts.where(:student_id => @id_array).includes(:student, :group, :discount, :payment_type) if (!@id_array.empty?)

      @group = params[:group_id]
      @special_group = params[:special_group_id]
    else
      @contracts = Contract.where(:student_id => @id_array).includes(:student, :group, :discount, :payment_type)
    end
  end

  # GET /contracts/1
  # GET /contracts/1.json
  def show
    (@contract.group) ? (@contractGroupTimetable = Timetable.where(:group_id => @contract.group.id).order(:weekday)) : (@contractGroupTimetable = [])
    #@current_season = Season.where(:seasonNo=> Setting.where(:settingName => 'Aktiw_tapgyr')[0].settingValue)[0]  # Get season number of current season from Settings object
    @current_season = Season.find_by_id(session[:active_season_id])  # Get season number of current season from Settings object
    @audits = Audit.where(:obj_id => @contract.id)
  end

  # GET /contracts/new
  def new
    @contract = Contract.new
    #session[:active_season_id]
    
    @contract.student_id = params[:student_id]                                                                          # Set this new contracts student the one with pressed id
    #@contract.season_id = Season.where(:seasonNo=> Setting.where(:settingName => 'Aktiw_tapgyr')[0].settingValue)[0].id # Set season of current new contract as the current season
    #@contract.season_id = Season.active_season.id
    @contract.season_id = session[:active_season_id]

    @contract.payment_type_id = PaymentType.find_by_paymentTypeName("NAGT").id                                      # Set this new contracts student the one with pressed id
    #@contract.amountPaid = 0

    @groups = Group.where(:season_id => session[:active_season_id]).order(:groupTitle)
    @students = Student.all
    @discounts = Discount.all
    @special_groups = SpecialGroup.where(:season_id => session[:active_season_id]).order(:specialGroupTitle)
    @seasons = Season.all.order(:seasonTitle)
    @payment_types = PaymentType.all.order(:paymentTypeName)
  end

  # GET /contracts/1/edit
  def edit
    @groups = Group.where(:season_id => session[:active_season_id]).order(:groupTitle)
    @students = Student.all
    @discounts = Discount.all
    @special_groups = SpecialGroup.where(:season_id => session[:active_season_id]).order(:specialGroupTitle)
    @seasons = Season.all.order(:seasonTitle)
    @payment_types = PaymentType.all.order(:paymentTypeName)

  end

  # GET /agaly_report
  # GET /agaly_report.json
  def mycontractssearch
    @current_season_id = session[:active_season_id]

    @audit_id_array = []
    @contract_id_array = []
    @contract_id_array_for_dates = []



    #@my_registrar_roles_ids = Role.where(:)

    #@my_roles_users = RolesUser.where(:user_id => current_user.id).select(:role_id)
    #@my_roles_users.each{|a| @role_id_array.push(a.role_id)}

    if (params[:date_id].to_i != 0)
      #@my_contract_ids = Role.find_by_sql("select authorizable_id from roles  WHERE id IN '#{@role_id_array}' AND DATE(created_at) = '#{params[:date_id]}' ORDER BY created_at DESC")
      #@my_contract_ids = Role.where(:id => @role_id_array).select(:authorizable_id)
      #@my_contract_ids = Role.where(:id => @role_id_array).order('created_at DESC').select(:authorizable_id)
      @audit_created_contract_ids = Audit.where(:user_id => current_user.id, :mod_action_id => ModAction.find_by_modActionName_and_mod_object_id('create', ModObject.find_by_modObjectName('contracts').id)).select(:obj_id)
      @audit_updated_contract_ids = Audit.where(:user_id => current_user.id, :mod_action_id => ModAction.find_by_modActionName_and_mod_object_id('update', ModObject.find_by_modObjectName('contracts').id)).select(:obj_id)

      @my_created_contracts = Contract.where('id IN (?) AND DATE(created_at) = DATE(?)', @audit_created_contract_ids, params[:date_id]).includes(:student, :group, :discount, :payment_type).order('created_at DESC')
      @my_updated_contracts = Contract.where('id IN (?) AND DATE(created_at) = DATE(?)', @audit_updated_contract_ids, params[:date_id]).includes(:student, :group, :discount, :payment_type).order('created_at DESC')
      #Role.where('name=? AND id IN (?) AND DATE(created_at) = DATE(?)', 'registrar', @role_id_array, params[:date_id]).order('created_at DESC').select(:authorizable_id)

      #@my_contract_ids_for_dates = Role.where('name=? AND id IN (?)', 'registrar', @role_id_array).order('created_at DESC').select(:authorizable_id)

      #@my_contract_ids = @my_contract_ids.where('DATE(created_at) = ?', params[:date_id].to_s)
    else
      @audit_created_contract_ids = Audit.where(:user_id => current_user.id, :mod_action_id => ModAction.find_by_modActionName_and_mod_object_id('create', ModObject.find_by_modObjectName('contracts').id)).select(:obj_id)
      @audit_updated_contract_ids = Audit.where(:user_id => current_user.id, :mod_action_id => ModAction.find_by_modActionName_and_mod_object_id('update', ModObject.find_by_modObjectName('contracts').id)).select(:obj_id)

      @my_created_contracts = Contract.where('id IN (?)', @audit_created_contract_ids).includes(:student, :group, :discount, :payment_type).order('created_at DESC')
      @my_updated_contracts = Contract.where('id IN (?)', @audit_updated_contract_ids).includes(:student, :group, :discount, :payment_type).order('created_at DESC')

    end

    #@my_contract_ids.each{|a| @contract_id_array.push(a.authorizable_id)}
    #@my_contract_ids_for_dates.each{|a| @contract_id_array_for_dates.push(a.authorizable_id)}

    #@my_contracts = Contract.where(:season_id => session[:active_season_id], :id => @contract_id_array).all

    #@my_dates = @my_contracts.select(:created_at).distinct
    #@my_dates = @my_contracts.select('distinct created_at')

    @current_season = Season.find_by_id(session[:active_season_id])
    #@my_dates = @my_contracts.find_by_sql("select DISTINCT(DATE(created_at)) as created_at from contracts WHERE created_at > ? AND created_at < ? ORDER BY created_at DESC", @current_season.seasonFromDate, @current_season.seasonToDate)
    #@my_dates = @my_contracts.find_by_sql("select DISTINCT(DATE(created_at)) as created_at from contracts  ORDER BY created_at DESC")
    #@my_dates = @my_contracts.find_by_sql("select DISTINCT(DATE(created_at)) as created_at from contracts  WHERE created_at > '#{@current_season.seasonFromDate}' AND created_at < '#{@current_season.seasonToDate}' ORDER BY created_at DESC")
    #@my_dates = Contract.select('DATE(created_at) as created_at').distinct.where('created_at > ?', @current_season.seasonFromDate).where('created_at < ?', @current_season.seasonToDate).where(:season_id => session[:active_season_id], :id => @contract_id_array).order('created_at DESC')
    #@my_dates = Contract.where(:season_id => session[:active_season_id], :id => @contract_id_array_for_dates).select('DATE(created_at) as created_at').distinct.order('created_at DESC')
    @my_dates = Audit.where(:user_id => current_user.id).select('DATE(created_at) as created_at').distinct.order('created_at DESC')
    #find_by_sql("select DISTINCT(DATE(created_at)) as created_at from contracts  WHERE created_at > '#{@current_season.seasonFromDate}' AND created_at < '#{@current_season.seasonToDate}' ORDER BY created_at DESC")
    @my_dates_array = []
    @my_dates.each{|d| @my_dates_array.push(d.created_at)}
    #@my_dates = @my_dates.where("created_at > ? AND created_at < ?", @current_season.seasonFromDate, @current_season.seasonToDate)

    #@my_dates = @my_contracts.count(:group => "DATE(created_at)")
    #@duplicate_contracts = Contract.where(:season_id => session[:active_season_id]).find_by_sql("select student_id, group_id, count(*) from contracts group by student_id, group_id having count(*)>1")
    #@my_dates = Contract.where(:season_id => session[:active_season_id], :id => @contract_id_array).all.select(:created_at)
    @current_date = params[:date_id].to_s
    @current_name = params[:fName]

  end


  # GET /agaly_report
  # GET /agaly_report.json
  def mycontractsreport
    @current_season_id = session[:active_season_id]

    @role_id_array = []
    @contract_id_array = []
    @contract_id_array_for_dates = []



    #@my_registrar_roles_ids = Role.where(:)

    @my_roles_users = RolesUser.where(:user_id => current_user.id).select(:role_id)
    @my_roles_users.each{|a| @role_id_array.push(a.role_id)}

    if (params[:date_id].to_i != 0)
      @audit_created_contract_ids = Audit.where(:user_id => current_user.id, :mod_action_id => ModAction.find_by_modActionName_and_mod_object_id('create', ModObject.find_by_modObjectName('contracts').id)).select(:obj_id)
      @audit_updated_contract_ids = Audit.where(:user_id => current_user.id, :mod_action_id => ModAction.find_by_modActionName_and_mod_object_id('update', ModObject.find_by_modObjectName('contracts').id)).select(:obj_id)

      @my_created_contracts = Contract.where('id IN (?) AND DATE(created_at) = DATE(?)', @audit_created_contract_ids, params[:date_id]).includes(:student, :group, :discount, :payment_type).order('created_at DESC')
      @my_updated_contracts = Contract.where('id IN (?) AND DATE(created_at) = DATE(?)', @audit_updated_contract_ids, params[:date_id]).includes(:student, :group, :discount, :payment_type).order('created_at DESC')
    else
      #@my_contract_ids = Role.where(:id => @role_id_array, :name => 'registrar').select(:authorizable_id)
      #@my_contract_ids_for_dates = @my_contract_ids
      @audit_created_contract_ids = Audit.where(:user_id => current_user.id, :mod_action_id => ModAction.find_by_modActionName_and_mod_object_id('create', ModObject.find_by_modObjectName('contracts').id)).select(:obj_id)
      @audit_updated_contract_ids = Audit.where(:user_id => current_user.id, :mod_action_id => ModAction.find_by_modActionName_and_mod_object_id('update', ModObject.find_by_modObjectName('contracts').id)).select(:obj_id)

      @my_created_contracts = Contract.where('id IN (?)', @audit_created_contract_ids).includes(:student, :group, :discount, :payment_type).order('created_at DESC')
      @my_updated_contracts = Contract.where('id IN (?)', @audit_updated_contract_ids).includes(:student, :group, :discount, :payment_type).order('created_at DESC')
    end


    @current_season = Season.find_by_id(session[:active_season_id])
    @my_dates = Audit.where(:user_id => current_user.id).select('DATE(created_at) as created_at').distinct.order('created_at DESC')

    #####################################

    @current_season = Season.find_by_id(session[:active_season_id])
    @my_dates = Audit.where(:user_id => current_user.id).select('DATE(created_at) as created_at').distinct.order('created_at DESC')

    @my_dates_array = []
    @my_dates.each{|d| @my_dates_array.push(d.created_at)}

    @current_date = params[:date_id].to_s
    @current_name = params[:fName]

    render :layout => false
  end


  # GET /repeating
  # GET /repeating.json
  def repeating
    @duplicate_contracts = Contract.where(:season_id => session[:active_season_id]).find_by_sql("select student_id, group_id, \"isMoneyReturned\", count(*) from contracts group by student_id, group_id, \"isMoneyReturned\" having count(*)>1").includes(:student, :group, :discount, :payment_type)
    #@duplicate_contracts = Contract.where(:season_id => session[:active_season_id]).find_by_sql("select student_id, group_id, count(*) from contracts group by student_id, group_id having count(*)>1")
    @groupless_contracts = Contract.where(:season_id => session[:active_season_id], :group_id => NIL).includes(:student, :group, :discount, :payment_type)
  end

  # GET /birthdays
  # GET /birthdays.json
  def birthdays

    if (!params[:month_id].blank? && !params[:day_id].blank? )
      @month = params[:month_id].to_i + 1
      @day = params[:day_id].to_i

      @current_season_id = session[:active_season_id]
      #@current_season_contracts = Contract.where(:season_id => @current_season_id, :isMoneyReturned => false).includes(:season, :group, :student)                              # Get contracts list from current season
      @current_season_student_ids = Contract.where(:season_id => @current_season_id, :isMoneyReturned => false).select(:student_id)                             # Get contracts list from current season
      @current_season_students = Student.where(:id => @current_season_student_ids)
    else
      #@current_season_contracts = Contract.where(:id => []).includes(:season, :group, :student)                              # Get contracts list from current season
      @current_season_student_ids = Contract.where(:id => []).select(:student_id)                              # Get contracts list from current season
      @current_season_students = Student.where(:id => @current_season_student_ids)
    end
  end


  # GET /reserve
  # GET /reserve.json
  def reserve
    @reserve_contracts = Contract.where(:season_id => session[:active_season_id], :isReserve => 'TRUE').includes(:student, :group)
  end

  # GET /general_report
  # GET /general_report.json
  def general_report
    @season_contracts = Contract.where(:season_id => session[:active_season_id]).all

    @report_contracts = @season_contracts.where(:isReserve => 'FALSE', :isMoneyReturned => 'FALSE').includes(:student, :group, :payment_type).all
    @returned_contracts = @season_contracts.where(:isMoneyReturned => 'TRUE').includes(:student, :group, :payment_type).all
    @reserved_contracts = @season_contracts.where(:isReserve => 'TRUE').includes(:student, :group, :payment_type).all

    #@current_season_id = session[:active_season_id]
    #@current_season = Season.find_by_id(@current_season_id)

    #@report_contracts = @current_season.cached_current_season_active_contracts.where(:isReserve => false)
    #@returned_contracts = @current_season.cached_current_season_returned_contracts
    #@reserved_contracts = @current_season.cached_current_season_active_contracts.where(:isReserve => true)
  end

  # GET /agaly_report
  # GET /agaly_report.json
  def agaly_report
    @report_contracts = Contract.where(:season_id => session[:active_season_id], :isMoneyReturned => 'FALSE').includes(:group, :student).all
  end

  # GET /tgb_report
  # GET /tgb_report.json
  def tgb_report
    @current_season_id = session[:active_season_id]

    @contracts_all = Contract.where(:season_id => @current_season_id).includes(:payment_type, :season, :group, :student, :discount)                              # Get contracts list from current season

    @contracts_returned = @contracts_all.where(:isMoneyReturned => true)                        # Get contracts list from current season
    #@contracts_reserved = @contracts_all.where(:isReserve => true)                              # Get contracts list from current season


    @season_start_report_contracts = Contract.where(:season_id => session[:active_season_id], :isMoneyReturned => 'FALSE', :group_id => Group.where(:season_id => session[:active_season_id], :isClosed => false).select(:id)).all
    #@season_end_report_contracts = Contract.where(:season_id => session[:active_season_id], :group_id => Group.where(:season_id => session[:active_season_id]).select(:id)).all
    @season_end_report_contracts = Contract.where(:season_id => session[:active_season_id]).all
  end

  # GET /tgb_report
  # GET /tgb_report.json
  def passers_check_report
    @current_season_id = session[:active_season_id]

    @current_season_contracts = Contract.where(:season_id => @current_season_id).includes(:season, :group, :student, :final).order(:seasonContractNo)                              # Get contracts list from current season
    @prev_season_contracts = Contract.where(:season_id => @current_season_id-1).includes(:season, :group, :student, :final).order(:seasonContractNo)                              # Get contracts list from current season

  end

  def photoless_report
    @current_season_id = session[:active_season_id]

    @current_season_contracts = Contract.where(:season_id => @current_season_id, :isMoneyReturned => false).includes(:season, :group, :student, :final).order(:seasonContractNo)                              # Get contracts list from current season
    #@prev_season_contracts = Contract.where(:season_id => @current_season_id-1).includes(:season, :group, :student, :final).order(:seasonContractNo)                              # Get contracts list from current season

  end

  def incorrect_phones_report
    @current_season_id = session[:active_season_id]

    # To calculate students with incorrect phones of current season.
    @current_season_contracts = Contract.where(:season_id => @current_season_id, :isMoneyReturned => false)
    @current_season_student_id = @current_season_contracts.select(:student_id)

    @tmp_array_of_student_ids = Array.new(@current_season_student_id.each{|el| el.student_id })

    @id_array = []
    @tmp_array_of_student_ids.each{|a| @id_array.push(a.student_id)}

    @season_students = Student.where(:id => @id_array).order(:fName)
    @students_with_incorrect_phones = @season_students.where("(length(\"mobilePhone\")>0 AND length(\"mobilePhone\") <> 8) OR length(\"smsMobilePhone\") <> 8 ")

  end

  def discount_report
    @current_season_id = session[:active_season_id]

    @current_season_discount_contracts = Contract.where(:season_id => @current_season_id, :isMoneyReturned => false).includes(:season, :group, :student, :discount).order(:seasonContractNo)                              # Get contracts list from current season
  end

  # GET /repeating
  # GET /repeating.json
  def health_notes_report
    @current_season_id = session[:active_season_id]

    @current_season_contracts = Contract.where(:season_id => @current_season_id, :isMoneyReturned => false).includes(:season, :group, :student).order(:seasonContractNo)                        # Get contracts list from current season
  end


  # GET /contracts/1
  # GET /contracts/1.json
  def att_report
    @season_start_date = @contract.group.season.seasonFromDate
    @season_end_date = @contract.group.season.seasonToDate

    @group_lesson_weekdays = @contract.group.timetables.select(:weekday)
    @weekday_array = []
    @group_lesson_weekdays.each{|a| @weekday_array.push(a.weekday)}

    render :layout => false
  end


  # GET /contracts/1
  # GET /contracts/1.json
  def invoice
    #@current_season = Season.where(:seasonNo=> Setting.where(:settingName => 'Aktiw_tapgyr')[0].settingValue)[0]  # Get id of current season from Settings object
    @current_season = Season.find_by_id(session[:active_season_id])

    @contractGroupTimetable = Timetable.where(:group_id => @contract.group.id).order(:weekday)

    render :layout => false
  end

  # GET /contracts/1
  # GET /contracts/1.json
  def content_ru
    #@current_season = Season.where(:seasonNo=> Setting.where(:settingName => 'Aktiw_tapgyr')[0].settingValue)[0]  # Get id of current season from Settings object
    @current_season = Season.find_by_id(session[:active_season_id])

    @contractGroupTimetable = Timetable.where(:group_id => @contract.group.id)

    render :layout => false
  end

  # GET /contracts/1
  # GET /contracts/1.json
  def content_tm
    #@current_season = Season.where(:seasonNo=> Setting.where(:settingName => 'Aktiw_tapgyr')[0].settingValue)[0]  # Get id of current season from Settings object
    @current_season = Season.find_by_id(session[:active_season_id])

    @contractGroupTimetable = Timetable.where(:group_id => @contract.group.id)

    render :layout => false
  end

  def birthday_sms_sender
    #@this_season_contracts = Contract.where(:season_id => session[:active_season_id]).select(:student)
    @this_season_students = Contract.where(:season_id => Season.where(:seasonNo=> Setting.where(:settingName => 'Aktiw_tapgyr')[0].settingValue)[0].id).select(:student_id)
    #@sms_receivers = Student.where(:id => @this_season_students, :birthDate.month => Date.today.month, :birthDate.day => Date.today.day)
    @sms_receivers = Student.where("id IN (?) AND EXTRACT( MONTH FROM \"birthDate\")=(?) AND EXTRACT( DAY FROM \"birthDate\")=(?) ", @this_season_students, Date.today.month, Date.today.day)

    #@my_created_contracts = Contract.where('id IN (?) AND DATE(created_at) = DATE(?)', @audit_created_contract_ids, params[:date_id]).order('created_at DESC')
    render :layout => 'nosidebar'
  end


  # POST /contracts
  # POST /contracts.json
  def create
    @contract = Contract.new(contract_params)

    @groups = Group.where(:season_id => session[:active_season_id]).order(:groupTitle)
    @students = Student.all
    @discounts = Discount.all
    @seasons = Season.all.order(:seasonTitle)
    @payment_types = PaymentType.all.order(:paymentTypeName)
    @special_groups = SpecialGroup.where(:season_id => session[:active_season_id]).order(:specialGroupTitle)

    if (params[:contract][:isReserve]=="1" || params[:contract][:payment_type_id].to_s==PaymentType.find_by_paymentTypeName("BANK AMALY").id.to_s || params[:contract][:payment_type_id].to_s==PaymentType.find_by_paymentTypeName("KART AMALY").id.to_s)
      @contract.seasonContractNo = 0

      if (params[:contract][:payment_type_id].to_s==PaymentType.find_by_paymentTypeName("BANK AMALY").id.to_s)
        @this_season_all_bank_contracts = Season.find_by_id(session[:active_season_id]).contracts.where(:payment_type_id => PaymentType.where(:paymentTypeName => "BANK AMALY")[0].id)
        @contract.otherContractNo = "B-"+(@this_season_all_bank_contracts.count+1).to_s
        #something for a bank account payment
      elsif (params[:contract][:payment_type_id].to_s==PaymentType.find_by_paymentTypeName("KART AMALY").id.to_s)
        @this_season_all_card_contracts = Season.find_by_id(session[:active_season_id]).contracts.where(:payment_type_id => PaymentType.where(:paymentTypeName => "KART AMALY")[0].id)
        @contract.otherContractNo = "K-"+(@this_season_all_card_contracts.count+1).to_s
        #something for a card payment
      end
    else
      if (Contract.where(:season_id => session[:active_season_id]).maximum("seasonContractNo"))
        @contract.seasonContractNo = Contract.where(:season_id => session[:active_season_id]).maximum("seasonContractNo") + 1   # Set new contracts seasonNo number the next number from maximum of the databases
      else
        @contract.seasonContractNo = 1
      end
    end

    respond_to do |format|

      @duplicate_contract = Contract.where(:student_id => @contract.student.id, :group_id => @contract.group.id, :isMoneyReturned => false)
      @duplicate_message = "BU DIŇLEÝJI EÝÝÄM BU TOPARA ÝAZYLAN => "

      if ((@duplicate_contract.count==0) && (@contract.save))
      #if @contract.save
        #current_user.has_role! :registrar, @contract
        register_audit (@contract.id)
        Season.flush_season_active_contracts_cache

        format.html { redirect_to @contract, notice: 'Şertnama üstünlikli girizildi.' }
        format.json { render :show, status: :created, location: @contract }
      else
        format.html { render :new }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contracts/1
  # PATCH/PUT /contracts/1.json
  def update
    @groups = Group.where(:season_id => session[:active_season_id]).order(:groupTitle)
    @students = Student.all
    @discounts = Discount.all
    @seasons = Season.all.order(:seasonTitle)
    @payment_types = PaymentType.all.order(:paymentTypeName)


    if ((params[:contract][:isReserve]=="1") or (params[:contract][:payment_type_id].to_s==PaymentType.find_by_paymentTypeName("BANK AMALY").id.to_s) or (params[:contract][:payment_type_id].to_s==PaymentType.find_by_paymentTypeName("KART AMALY").id.to_s))
      @contract.seasonContractNo = 0
      #@contract.amountPaid = 1

      if (params[:contract][:payment_type_id].to_s==PaymentType.find_by_paymentTypeName("BANK AMALY").id.to_s) && (@contract.otherContractNo.to_s=="")
        @this_season_all_bank_contracts = Season.find_by_id(session[:active_season_id]).contracts.where(:payment_type_id => PaymentType.where(:paymentTypeName => "BANK AMALY")[0].id)
        @contract.otherContractNo = "B-"+(@this_season_all_bank_contracts.count+1).to_s
        @contract.registrationDate = Date.today
        #something for a bank account payment
      end
      if (params[:contract][:payment_type_id].to_s==PaymentType.find_by_paymentTypeName("KART AMALY").id.to_s && @contract.otherContractNo.to_s=="")
        @this_season_all_card_contracts = Season.find_by_id(session[:active_season_id]).contracts.where(:payment_type_id => PaymentType.where(:paymentTypeName => "KART AMALY")[0].id)
        @contract.otherContractNo = "K-"+(@this_season_all_card_contracts.count+1).to_s
        @contract.registrationDate = Date.today
        #something for a card payment
      end

    else
      if (@contract.seasonContractNo == 0)
        params[:contract][:seasonContractNo] = Contract.where(:season_id => session[:active_season_id]).maximum("seasonContractNo") + 1   # Set new contracts seasonNo number the next number from maximum of the databases
        @contract.created_at = Date.today  # Rezerw adaty şertnama öwrülen senesini ýazmaly, ýagny şu günki sene
        @contract.registrationDate = Date.today
        #@contract.amountPaid = 2
      end
    end

    respond_to do |format|
      if @contract.update(contract_params)
        #current_user.has_role! :editor, @contract
        register_audit (@contract.id)
        Season.flush_season_active_contracts_cache

        format.html { redirect_to @contract, notice: 'Contract was successfully updated.' }
        format.json { render :show, status: :ok, location: @contract }
      else
        format.html { render :edit }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contracts/1
  # PATCH/PUT /contracts/1.json
  def return_payment
    @contract.update_attribute(:isMoneyReturned, true)
    #redirect_to @contract, notice: 'Şertnama üstünlikli gaýtaryldy.'
    respond_to do |format|
      format.html { redirect_to @contract, notice: 'Ýazylyşyk üstünlikli gaýtaryldy.' }
      format.json { render :show, status: :ok, location: @contract }
    end
  end


  # DELETE /contracts/1
  # DELETE /contracts/1.json
  def destroy
    @contract.destroy
    Season.flush_season_active_contracts_cache

    respond_to do |format|
      format.html { redirect_to search_contracts_url, notice: 'Ýazylyşyk üstünlikli bozuldy.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contract
      @contract = Contract.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contract_params
      params.require(:contract).permit(:seasonContractNo, :otherContractNo, :otherReceiptNo, :isReserve, :payment_type_id, :season_id, :group_id, :student_id, :discount_id, :registrationDate, :isBookGiven, :amountPaid, :isMoneyReturned, :notes, :discountReason, :moneyReturnReason, :special_group_id )
    end
end
