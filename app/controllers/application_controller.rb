class ApplicationController < ActionController::Base

  #check_authorization
  #  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

end
