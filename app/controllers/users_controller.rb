class UsersController < ApplicationController

  def new
    User.new(id, params)
  end

  def create

  end

  def show
    @user
  end

  def edit

  end

  def save
    #pass in params in hash from view
    @user.change_attributes(params)
  end

  def destroy
    @user.destroy
  end
end
