#1. @current_user is nil
#2. cannot access session variables
class UsersController < ApplicationController
  before_filter :require_login, only: [:show, :edit, :update, :destroy]
  skip_before_filter :current_user?

  respond_to :json
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

  def search_disorders
    @disorders = User.find_disorders(params[:q], session[:api_key])
    respond_with_json(@disorders)
  end

  def find_a_disorder
    @disorder = User.find_a_disorder(params[:cui], session[:api_key])
    respond_with_json(@disorder)
  end

  def search_treatments
    @treatments = User.find_treatments(params[:q], session[:api_key])
    respond_with_json(@treatments)
  end

  def find_prescriptions_for_disorder
    @prescriptions = User.find_prescriptions(params[:cui], session[:api_key])
    respond_with_json(@prescriptions)
  end

  def add_prescription
    @new_prescription = User.new_prescription(params, session[:api_key])
    respond_with_json(@new_prescription)
  end

  def respond_with_json(response)
    respond_with(response) do |format|
      format.json
    end
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