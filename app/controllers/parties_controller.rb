class PartiesController < ApplicationController

  def show
    @party = Party.find(params[:id])
    @party_sponsors = @party.related_subjects.group("subject_id").order("sum_amount desc").sum("amount")
    @party_sponsors = @party_sponsors.inject({}) do |hash, key_value|
      hash[Subject.find(key_value[0])] = key_value[1]
      hash
    end
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
