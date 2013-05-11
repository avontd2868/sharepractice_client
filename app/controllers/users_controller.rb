class UsersController < ApplicationController
  #before_filter :require_login
  # skip_before_filter :verify_authenticity_token
  # before_filter :authenticate_user #if you dont have token

  # def new
  #   @user = User.new(response)
  # end

  # def create
  #   @user = User.new()
  #   # if @user.save
  #   #   redirect_to @user
  #   # end
  #   #   render :new
  #   # end
  # end

  def show
    @id = session[:current_user_id]
    @user = User.find_by_id(session[:current_user_id])
    #if signed_in?
    #  render @user
    #else
    #  redirect_to signin_path
    #end
  end

  def signed_in?
    !@current_user.nil?
  end
  # def edit
  #   @user 
  # end

  # def update
  #   #pass in params in hash from view
  #   @user.change_attributes(params)
  # end

  # def destroy
  #   @user.destroy
  # end
end