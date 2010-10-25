class Datanest::PartySponsor < ActiveRecord::Base
  extend Datanest::Import

  csv           'sponzori_stran-dump.csv'
  before_create :convert_financial_attributes, :correct_party_names
end
