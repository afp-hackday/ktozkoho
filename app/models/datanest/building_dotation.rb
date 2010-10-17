class Datanest::BuildingDotation < ActiveRecord::Base
  extend CSV::Import

  csv                         'dotacie_vystavba-dump.csv'
  additional_currency_columns :project_value
  after_import                :normalize_currency, :null_icos, :empty_columns_to_null

  def address
    city || ''
  end
end
