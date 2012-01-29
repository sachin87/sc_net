class ApplicationController < ActionController::Base

  #check_authorization
  #  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def check_role(role)
    unless current_user && current_user.has_role?(role)
      flash[:error] = "You do not have the permission to do that."
      #redirect_to root_path
    end
  end
  
  def check_administrator_role
    check_role('Administrator')
  end

  def check_moderator_role
    check_role('Moderator')
  end

end