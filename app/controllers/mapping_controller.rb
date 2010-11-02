class MappingController < ApplicationController
  def index
    @datanest_models = [Datanest::PartySponsor,
                        Datanest::PartyLoan,
                        Datanest::AgroDotation,
                        Datanest::BuildingDotation,
                        Datanest::Consolidation,
                        Datanest::CultureDotation,
                        Datanest::Eurofond,
                        Datanest::ForgivenToll,
                        Datanest::OtherDotation,
                        Datanest::Privatization,
                        Datanest::Procurement]
  end

  def entities
    entity = "Datanest::#{params[:type].classify}".constantize
    @entity_type = params[:type]
    @party_sponsors = []
  end

  def load
    entity = "Datanest::#{params[:type].classify}".constantize
    @party_sponsors = entity.find_and_lock_unmapped(params[:limit])
    render :layout => false
  end
end
