#coding: utf-8
class Datanest::Privatization < ActiveRecord::Base
  extend Datanest::Import
  extend Datanest::ManuallyMappable

  csv            'privatizacia_predaje-dump.csv'
  before_create  :convert_financial_attributes, :empty_attributes_to_null
  display_name   'Privatizácie'
end
