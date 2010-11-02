#coding: utf-8
class Datanest::BuildingDotation < ActiveRecord::Base
  extend Datanest::Import
  extend Datanest::ManuallyMappable

  csv                         'dotacie_vystavba-dump.csv'
  additional_currency_columns :project_value
  before_create               :convert_financial_attributes, :empty_attributes_to_null
  display_name                'Stavebné dotácie'

  def address
    city || ''
  end
end
