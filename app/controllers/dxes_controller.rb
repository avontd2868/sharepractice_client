class DxesController < ApplicationController

  # GET /dxes
  def index
    @all_dxes = Dx.all
    @search_result_dxes
    @dx = Dx.new
  end

  def create
    @dx = Dx.new(dx_params) #replaced params[:dx] for rails 4
    respond_to do |format|
      if @dx.save
        format.js
        #render json: @dx, status: :created, location: @dxes
      else
        render 'index'
      end
    end
  end

  def edit
    @dx = Dx.find(params[:id])
  end

  def update
    @dx = Dx.find(params[:id])

    respond_to do |format|
      if @dx.update_attributes(dx_params)
        format.json { head :no_content }
      else
        render 'error'
      end
    end
  end

  def show
    @dx = Dx.find(params[:id])
  end
 
  def destroy
    @dx = Dx.find(params[:id])
    @dx.destroy

    respond_to do |format|
      #format.json { render :nothing => true }
      format.js
    end
    #TODO: process errors
  end

  private

  def dx_params
    params.require(:dx).permit(:codes, :definition, :dx_code, :name, :resource_uri, :id)
    #same as following, except prevents nil errors from occuring
    #params[:dx].permit(:codes, :definition, :dx_code, :name, :resource_uri, :id)
  end
end
