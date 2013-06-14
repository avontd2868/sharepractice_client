class DxesController < ApplicationController

  respond_to :js

  def index
    @all_dxes = Dx.all
    #@search
    #@search_dxes = Dx.search_by_name(dx_params[:name])
    @dx = Dx.new(empty_params)
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
    @dx = Dx.find(params[:id])
    @dx.destroy

    respond_to do |format|
      format.js
    end
    #TODO: process errors
  end

  # def show
  #   disorder = Disorder.find(params[:id])
  #   if disorder then
  #     treatments = Rx.txs(disorder.sp_code)
  #     resource_uri = []
  #     results = { :dx_code => disorder.sp_code, :name => disorder.label, :definition => disorder.definition, :codes => disorder.codes, :resource_uri => resource_uri, :treatments => treatments }
  #     results[:treatment_count] = treatments.length
  #     results[:generic_treatments] = [] if nil # TODO
  #     render :json => { :results => [ results ] }
  #   else
  #     render :json => { :success => :false, :message => "Disorder not found." }, :status => 404
  #   end
  # end

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
    params.require(:dx).permit(:name, :definition)
    #same as following, except prevents nil errors from occuring
    #params[:dx].permit(:codes, :definition, :dx_code, :name, :resource_uri, :id)
  end
end
