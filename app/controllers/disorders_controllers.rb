class DisordersController < ApplicationController

  def new
    disorder = Disorder.new('/disorder')
    @response = disorder.create(params[:name])
    respond_with_json(@response)
  end

  def show
    disorder = Disorder.new('/disorder')
    @response = disorder.find(params[:id])
    respond_with_json(@response)
  end

  def destroy
    disorder = Disorder.new('/disorder')
    @response = disorder.delete(params[:id])
    respond_with_json(@response)
  end

  private

  def respond_with_json(response)
    respond_with(response) do |format|
      format.json
    end
  end
end