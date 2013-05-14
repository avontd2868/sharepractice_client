#1. @current_user is nil
#2. cannot access session variables
class UsersController < ApplicationController
  before_filter :require_login, only: [:show, :edit, :update, :destroy]
  skip_before_filter :current_user?

  # def new
  #   @user = User.new_from_web(session[:user_id], @current_user.api_key, params[:user])
  # end

  # def create
  #   @user = User.new_from_web()
  #   if @user.save
  #     redirect_to @user
  #   end
  #     render :new
  #     send user confirmation email
  #   end
  # end

  def show
    @current_user = session[:current_user]
  end

  # def edit
  #   @user = User.edit_from_web(params[:user])
  # end

  # def update
  #   #pass in params in hash from view
  #   @user.change_attributes(params)
  # end

  # def destroy
  #   @user.destroy
  # end
end