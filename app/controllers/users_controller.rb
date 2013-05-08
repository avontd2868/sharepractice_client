class UsersController < ApplicationController

  # def new
  #   @user = User.new
  # end

  # def create
  #   @user = User.new(params[:user])
  #   if @user.save
  #     redirect_to @user
  #   end
  #     render :new
  #   end
  # end

  def show
    @user = SpUser.find_by_id(params[:id])
  end

  # def edit
  #   @user 
  # end

  # def save
  #   #pass in params in hash from view
  #   @user.change_attributes(params)
  # end

  # def destroy
  #   @user.destroy
  # end
end
