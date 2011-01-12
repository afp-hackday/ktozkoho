class SubjectsController < ApplicationController
  def update
    entity = "Datanest::#{params[:type].classify}".constantize.find(params[:id])
    if params[:related_organisation_id] == "none"
      entity.link_matched_subject nil, "impossible"
    else
      entity.link_matched_subject(Datanest::Organisation.find(params[:related_organisation_id]), "manual")
    end

    entity.save

    render :nothing => true
  end
end
