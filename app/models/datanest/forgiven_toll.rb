class Datanest::ForgivenToll < ActiveRecord::Base
  extend CSV::Import

  csv          'odpustene_clo-dump.csv'
  after_import :normalize_currency, :null_icos, :empty_columns_to_null
end
