class Datanest::AgroDotation < ActiveRecord::Base
  extend Datanest::Import

  csv           'polnodotacie-dump.csv'
  before_create :convert_financial_attributes
end
