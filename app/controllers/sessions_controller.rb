class SessionsController < ApplicationController

  def new
  end

  def create
    @current_user = User.login(params[:email], params[:password])

    #if the user can be found, and the password is correct, it will return a User instance
    puts "USER ID IS NIL? #{@current_user.to_yaml}" #when correct login credentials used, there is email and authenticity token stored, but no other user attributes
    unless @current_user.nil?
      # Save the user ID in the session so it can be used in subsequent requests
      session[:current_user] = @current_user
      session[:user_id] = @current_user.id
      session[:api_key] = @current_user.api_key
      redirect_to profile_path, notice: "Logged in!"
    else
      # this is not showing, even when before filter is taken out from users controller
      flash.now.alert = "Email or password is invalid"
      render 'new'
    end
  end

  def destroy
    reset_session
    redirect_to root_url, notice: "Logged out!"
  end

  # def current_user=(user)
  #   @current_user = user
  # end

  # def sign_in(user)
  #   cookies.permanent[:remember_token] = user.remember_token
  #   @current_user = user
  # end

  # def sign_out
  #   current_user = nil
  #   cookies.delete(:remember_token)
  # end

  # def authenticate_user
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