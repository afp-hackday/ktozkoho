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
    @entity_type = params[:type]
  end

  def load
    entity = "Datanest::#{params[:type].classify}".constantize
    @entities = entity.find_and_lock_unmapped(params[:limit])

    respond_to do |format|
      format.json { render :json => @entities }
    end
  end
end
