class PartiesController < ApplicationController

  def show
    @party = Party.find(params[:id])
  end

  def portfolio
    respond_to do |format|
      format.json { render :json => Party.find(params[:id]).portfolio.to_json }
    end
  end

  def profits_per_year
    respond_to do |format|
      format.json { render :json => calculate_profits_per_year }
    end
  end

  private
  def calculate_profits_per_year
    Party.all.inject({}) do |hash, party|
      hash[party.acronym] = party.profits_of_related_subjects_per_year.values
      hash
    end
  end
end
