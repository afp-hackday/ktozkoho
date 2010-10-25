class Datanest::ForgivenToll < ActiveRecord::Base
  extend Datanest::Import

  csv            'odpustene_clo-dump.csv'
  before_create  :convert_financial_attributes
end
