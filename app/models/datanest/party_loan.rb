class Datanest::PartyLoan < ActiveRecord::Base
  extend Datanest::Import

  csv           'pozicky_stranam-dump.csv'
  before_create :convert_financial_attributes, :correct_party_names
end
