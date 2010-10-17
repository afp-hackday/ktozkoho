class Datanest::AgroDotation < ActiveRecord::Base
  extend CSV::Import

  csv         'polnodotacie-dump.csv'
  after_import :normalize_currency, :null_icos, :empty_columns_to_null
end
