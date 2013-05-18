class ApplicationController < ActionController::Base
  #protect_from_forgery
  # Filters are methods that are run before, after or “around” a controller action.
  # Filters are inherited, so if you set a filter on ApplicationController, it will be run on every controller in your application.
 
  private
 
  def current_user
    session[:current_user]
  end
  helper_method :current_user
  # Finds the User with the ID stored in the session with the key
  # :current_user_id. This is a common way to handle user login in
  # a Rails application; logging in sets the session value and
  # logging out removes it.

  def current_user?
    puts "CURRENT USER EXISTS?: #{!@current_user.nil?}"
    !@current_user.nil?
  end

  def require_login
    if current_user.nil?
      redirect_to login_path, alert: "You must be logged in to access this section"
    end
  end
end
