class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #make the below controller methods as helpers so that they can be accessed in the views
  helper_method :admin_user
  helper_method :current_user

  #the first user is the admin
  def admin_user
    @admin_user ||= User.first
  end

  #presently, there are only 2 users(admin/dealer and player) in the system
  def current_user
    @current_user ||= User.last
  end
end
