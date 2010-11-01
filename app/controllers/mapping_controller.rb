class MappingController < ApplicationController
  def index
    @party_sponsors = Datanest::PartySponsor.find_and_lock_unmapped(1)
  end

  def load_entities
    @party_sponsors = Datanest::PartySponsor.find_and_lock_unmapped(params[:limit])
    render :layout => false
  end
end
