class DashboardController < ApplicationController

  def index
  
    @parties = Party.all
    @profits_per_year = @parties.inject({}) do |hash, party|
      hash[party] = party.profits_of_related_subjects_per_year.values
      hash
    end

  end

end
