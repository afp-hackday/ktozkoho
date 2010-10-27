class Datanest::Procurement < ActiveRecord::Base
  extend Datanest::Import

  csv            'procurements_2-dump.csv'
  before_create  :convert_financial_attributes, :empty_attributes_to_null
end
