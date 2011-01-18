class PartiesController < ApplicationController

  def show
    @party = Party.find(params[:id])
  end

  def portfolio
    respond_to do |format|
      format.json {render :json => Party.find(params[:id]).portfolio.to_json}
    end
  end

end
