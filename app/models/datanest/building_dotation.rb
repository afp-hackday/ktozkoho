#coding: utf-8
class Datanest::BuildingDotation < ActiveRecord::Base
  include Datanest::Support::Import
  include Datanest::Support::ManuallyMappable

  csv                         'dotacie_vystavba-dump.csv'
  additional_currency_columns :project_value
  before_create               :convert_financial_attributes, :empty_attributes_to_null, :link_subject
  display_name                'Stavebné dotácie'

  belongs_to :subject

  def address
    city || ''
  end
end
