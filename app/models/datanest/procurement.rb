class Datanest::Procurement < ActiveRecord::Base
  extend Datanest::Import

  csv            'procurements_2-dump.csv'
  before_create  :convert_financial_attributes
end
