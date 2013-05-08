class ApplicationController < ActionController::Base
  protect_from_forgery

class SessionsController < ApplicationController
  def create
    user = User.from_oauth(env['omniauth.auth'])
    sign_in user
    if user.email.empty?
      flash[:alert] = "Please enter an email address"
      redirect_to edit_user_path(user)
    else
      redirect_to root_url
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

  private
  def current_user
    if cookies[:remember_token].present?
      @current_user ||= User.find_by_remember_token(cookies[:remember_token])
    end
  end

  def current_user=(user)
    @current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    @current_user = user
  end

  def sign_out
    current_user = nil
    cookies.delete(:remember_token)
  end
end
end
