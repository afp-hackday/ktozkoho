class DashboardController < ApplicationController

  def index
    @parties = Party.all
  end

end
