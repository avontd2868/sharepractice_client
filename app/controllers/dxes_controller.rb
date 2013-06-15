class DxesController < ApplicationController

  respond_to :js

  def index
    @all_dxes = Dx.all
    @dx = Dx.new(empty_params)
    #@search
    #@search_dxes = Dx.search_by_name(dx_params[:name])
  end

  def create
    if params.permitted?
      @dx = Dx.new(dx_params)

      unless @dx.save
        render 'index'
      end
    else
      #throw error
    end
  end

  # def edit
  #   @dx = Dx.find_by_id(params[:id])
  # end

  # def update
  #   @dx = Dx.find_by_id(params[:id])

  #   respond_to do |format|
  #     if @dx.update_attributes(dx_params)
  #       format.json { head :no_content }
  #     else
  #       render 'error'
  #     end
  #   end
  # end

  def show
    @dx = Dx.find_by_id(params[:id])
  end

  # def search
    # unless params[:search].blank?
    #   results = Dx.search_by_name(params[:search])
    #   format.js { render :json => {:results => results}}
    # else
    #   render :json => { :success => :false, :message => "Query can't be blank" }, :status => 422
    # end
  # end
 
  def destroy
    @dx = Dx.find_by_id(params[:id])
    Dx.destroy(params[:id])
  end

  private

  def empty_params
    ActionController::Parameters.new({
      dx: {
        name: '',
        definition: ''
      }
    })
  end

  def dx_params
    params.require(:dx).permit(:name, :definition, :id)
    #same as following, except prevents nil errors from occuring
    #params[:dx].permit(:codes, :definition, :dx_code, :name, :resource_uri, :id)
  end
end
