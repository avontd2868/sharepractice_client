class SessionsController < ApplicationController
#To reset the entire session, use reset_session.

# "Create" a login, aka "log the user in"
  def new
  end

  def create
    if user = User.login(params[:username], params[:password])
      # Save the user ID in the session so it can be used in
      # subsequent requests
      session[:current_user_id] = user.id
      redirect_to '/profile'
    end
  end

  # def verify_session
  #   if
  #     return
  #   else 
  #     create_session
  #   end
  # end

   # "Delete" a login, aka "log the user out"
  def destroy
    # Remove the user id from the session
    @_current_user = session[:current_user_id] = nil
    redirect_to root_url
  end

    # def current_user
  #   if cookies[:remember_token].present?
  #     @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  #   end
  # end

  # def current_user=(user)
  #   @current_user = user
  # end

  # def signed_in?
  #   !current_user.nil?
  # end

  # def sign_in(user)
  #   cookies.permanent[:remember_token] = user.remember_token
  #   @current_user = user
  # end

  # def sign_out
  #   current_user = nil
  #   cookies.delete(:remember_token)
  # end

  #   def authenticate_user
  #   if signed_in?
  #     current_user.email
  #     link_to 'Sign out', sign_out_path, method: :delete
  #   else
  #     link_to 'Sign in', sign_in_path
  #   end
  # end

  # def verify_authenticity_token
  #   # return if !User.find_by_authentication_token(params[:api_key])
  #   @current_user = User.find_by_authentication_token(params[:api_key])
  #   render :json => { :success => :false, :message => "Invalid API key." }, :status => 401 and return unless @current_user
  # end
end