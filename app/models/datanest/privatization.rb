class Datanest::Privatization < ActiveRecord::Base
  extend Datanest::Import

  csv            'privatizacia_predaje-dump.csv'
  before_create  :convert_financial_attributes, :empty_attributes_to_null
end
