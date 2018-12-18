class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :check_access
  helper_method :check_restrictions

  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  rescue_from 'Acl9::AccessDenied', :with => :access_denied

  private

  def access_denied
    if current_user
      render :template => 'home/access_denied'
    else
      #flash[:notice] = 'Access denied. Try to log in first.'
      redirect_to login_path
    end
  end

  def check_access
    #@check_object = ModActionsRole.where(:role_id => current_user.role.id, :modAction_id => ModAction.find_by_modObject_id_and_modActionName(ModObject.find_by_modObjectName(controller_name).id, action_name).id).first()
    if (!current_user)
      render 'layouts/restricted', :layout => 'nosidebar'
      return
    end

    if (ModObject.find_by_modObjectName(controller_name).nil?)
      render 'layouts/restricted', :layout => 'nosidebar'
      return false
    end

    if (ModAction.find_by_mod_object_id_and_modActionName(ModObject.find_by_modObjectName(controller_name).id, action_name).nil?)
      render 'layouts/restricted', :layout => 'nosidebar'
      return false
    end

    @check_object = ModActionsRole.where(:role_id => current_user.role.id, :mod_action_id => ModAction.find_by_mod_object_id_and_modActionName(ModObject.find_by_modObjectName(controller_name).id, action_name).id).first()

    if (!@check_object)
      render 'layouts/restricted', :layout => 'nosidebar'
      return
    elsif (!@check_object.allowAccess)
      render 'layouts/restricted', :layout => 'nosidebar'
      return
    end
  end

  def check_restrictions (cn, an)

    if (ModObject.find_by_modObjectName(cn).nil?)
      return false
    end

    if (ModAction.find_by_mod_object_id_and_modActionName(ModObject.find_by_modObjectName(cn).id, an).nil?)
      return false
    end

    @check_object = ModActionsRole.where(:role_id => current_user.role.id, :mod_action_id => ModAction.find_by_mod_object_id_and_modActionName(ModObject.find_by_modObjectName(cn).id, an).id).first()
    #if (!ModObject.find_by_modObjectName(cn).nil?)
      #if (!ModAction.find_by_modObject_id_and_modActionName(ModObject.find_by_modObjectName(cn).id, an).nil?)
        #@check_object = ModActionsRole.where(:role_id => current_user.role.id, :modAction_id => ModAction.find_by_modObject_id_and_modActionName(ModObject.find_by_modObjectName(cn).id, an).id).first()
      #else
        #return false;
      #end
    #else
      #return false;
    #end

    if (@check_object.nil?)
      return false
    elsif (!@check_object.allowAccess)
      return false
    else
      return true;
    end

  end


  def register_audit (ob_id)
    @mod_action = ModAction.find_by_mod_object_id_and_modActionName(ModObject.find_by_modObjectName(controller_name).id, action_name)
    @new_audit = Audit.new

    @new_audit.user_id = current_user.id
    @new_audit.mod_action_id = @mod_action.id
    @new_audit.interactionDate = DateTime.now
    @new_audit.obj_id = ob_id

    @new_audit.save
    #Audit.create(current_user.id, @mod_action.id, DateTime.now)
  end

end
