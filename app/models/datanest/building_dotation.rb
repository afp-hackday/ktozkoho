class Datanest::BuildingDotation < ActiveRecord::Base
  extend Datanest::Import

  csv                         'dotacie_vystavba-dump.csv'
  additional_currency_columns :project_value
  before_create               :convert_financial_attributes, :empty_attributes_to_null

  def address
    city || ''
  end
end
