class Datanest::CultureDotation < ActiveRecord::Base
  extend CSV::Import

  csv                         'dotacie_kultura-dump.csv'
  additional_currency_columns :budget, :dissaving
  after_import                :normalize_currency, :null_icos, :empty_columns_to_null
end
