#coding: utf-8
class Datanest::PartySponsor < ActiveRecord::Base
  extend Datanest::Support::Import
  extend Datanest::Support::ManuallyMappable

  csv           'sponzori_stran-dump.csv'
  before_create :convert_financial_attributes, :correct_party_names, :empty_attributes_to_null,
                :link_subject

  display_name  'Sponzori strán'

  belongs_to :subject
end
