class Datanest::BuildingDotation < ActiveRecord::Base
  extend Datanest::Import

  csv                         'dotacie_vystavba-dump.csv'
  additional_currency_columns :project_value
  before_create               :convert_financial_attributes

  def address
    city || ''
  end
end
