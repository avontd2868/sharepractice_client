class DxesController < ApplicationController
  
  # GET /dxes
  def index
    @all_dxes = Dx.all
    @search_result_dxes
    @dx = Dx.new
  end

  # GET /dxes/1
  # def show
  #   @dx = Dx.find(params[:id])
  # end

  # POST /dxes
  def create
    @dx = Dx.new(params[:dx])
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

  # PUT /dxes/1
  def update
    @dx = Dx.find(params[:id])

    respond_to do |format|
      if @dx.update_attributes(params[:dx])
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
      #format.html { redirect_to dxes_url }
      format.js
    end
  end
end
