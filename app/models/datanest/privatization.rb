class Datanest::Privatization < ActiveRecord::Base
  extend Datanest::Import

  csv            'privatizacia_predaje-dump.csv'
  before_create  :convert_financial_attributes
end
