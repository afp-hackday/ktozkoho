class Datanest::AgroDotation < ActiveRecord::Base
  extend Datanest::Import

  csv           'polnodotacie-dump.csv'
  before_create :convert_financial_attributes, :empty_attributes_to_null
end
