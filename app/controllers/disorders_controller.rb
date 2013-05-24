class DisordersController < ApplicationController
  respond_to :html

  def index
    @disorder = Disorder.new('/disorder')
  end

  def create
    rsolr = Disorder.new('/disorder')
    unless params[:name].blank?
      @disorder = rsolr.create(params[:name])
      redirect_to disorders_path
    else
      flash[:notice] = "You have successfully logged out"
      render :action => "index"
    end
  end

  def show
    @disorder = User.find_a_disorder(params[:cui], session[:api_key])
  end

  # def search
  #   @disorders = User.find_disorders(params[:q], session[:api_key])
  # end
end
