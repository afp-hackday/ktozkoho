class DashboardController < ApplicationController

  def index
  
    @parties = Party.all
    default_profits = (1993..Time.now.year).to_a.inject({}){|hash, year| hash[year] = 0; hash}
    @profits_per_year = @parties.inject({}) do |hash, party|
      hash[party] = default_profits.merge(party.profits_of_related_subjects_per_year).values
      hash
    end

  end

end
