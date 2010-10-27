class Datanest::CultureDotation < ActiveRecord::Base
  extend Datanest::Import

  csv                         'dotacie_kultura-dump.csv'
  additional_currency_columns :budget, :dissaving
  before_create               :convert_financial_attributes, :empty_attributes_to_null
end
