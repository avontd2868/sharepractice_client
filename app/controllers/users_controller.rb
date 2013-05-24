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
    response = handle_error_response(@disorders)
    respond_with_json(response)
  end

  def find_a_disorder
    @disorder = User.find_a_disorder(params[:cui], session[:api_key])
    response = handle_error_response(@disorder)
    respond_with_json(response)
  end

  def search_treatments
    @treatments = User.find_treatments(params[:q], session[:api_key])
    response = handle_error_response(@treatments)
    respond_with_json(response)
  end

  def find_prescriptions_for_disorder
    @prescriptions = User.find_prescriptions(params[:cui], session[:api_key])
    response = handle_error_response(@prescriptions)
    respond_with_json(response)
  end

  def add_prescription
    @new_prescription = User.new_prescription(params, session[:api_key])
    response = handle_error_response(@new_prescription)
    respond_with(@new_prescription, :location => nil)
  end

  private

  def respond_with_json(response)
    respond_with(response) do |format|
      format.json
    end
  end

  def handle_error_response(response)
    if response['success'] == "false"
      response = {:success => false, :message => response['message']}
      #TODO make status here reflected in actual HTTP status
      #currently shows response as status 201 even with: {:success => false, :message => frontline's response}
      #DOES NOT WORK: render :json => {:success => false, :message => response['message']}, :status => response['status']
    else
      response
    end
  end

  def handle_errors(response)
    case response.code
    when 200
    puts "All good!"
    when 404
    puts "O noes not found! #{response.body}"
    when 500...600
    puts "ZOMG ERROR #{response.code}"
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