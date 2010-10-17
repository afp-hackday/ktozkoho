class Datanest::Procurement < ActiveRecord::Base
  extend CSV::Import

  csv          'procurements_2-dump.csv'
  after_import :normalize_currency, :empty_columns_to_null
end
