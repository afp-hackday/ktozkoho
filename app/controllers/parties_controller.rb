class PartiesController < ApplicationController

  def show

  end

  def portfolio
    
    respond_to do |format|
      format.json {render :json => {'Tomas' => 50, 'Dusan' => 20}.to_json}
    end
  end

end
