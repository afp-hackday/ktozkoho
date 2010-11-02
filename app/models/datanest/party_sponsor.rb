#coding: utf-8
class Datanest::PartySponsor < ActiveRecord::Base
  extend Datanest::Import
  extend Datanest::ManuallyMappable

  csv           'sponzori_stran-dump.csv'
  before_create :convert_financial_attributes, :correct_party_names, :empty_attributes_to_null
  display_name  'Sponzori strán'
end
