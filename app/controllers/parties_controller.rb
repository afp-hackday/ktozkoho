class PartiesController < ApplicationController

  def show
    @party = Party.find(params[:id])
  end

  def portfolio
    respond_to do |format|
      format.json {render :json => {'Tomas' => 50, 'Dusan' => 20}.to_json}
    end
  end

end
