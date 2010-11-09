#coding: utf-8
class Datanest::PartySponsor < ActiveRecord::Base
  extend Datanest::Import
  extend Datanest::ManuallyMappable

  csv           'sponzori_stran-dump.csv'
  before_create :convert_financial_attributes, :correct_party_names, :empty_attributes_to_null,
                :link_organisation, :link_physical_person

  display_name  'Sponzori strán'

  belongs_to :subject
end
