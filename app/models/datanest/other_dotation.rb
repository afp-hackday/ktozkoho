class Datanest::OtherDotation < ActiveRecord::Base
  extend CSV::Import

  csv         'ine_dotacie-dump.csv'
  after_import :normalize_currency, :null_icos, :empty_columns_to_null
end
