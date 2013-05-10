class UsersController < ApplicationController
  before_filter :require_login
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

  # def show
  #   @user = User.find_by_id(params[:id])
  # end

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