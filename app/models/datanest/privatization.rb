class Datanest::Privatization < ActiveRecord::Base
  extend CSV::Import

  csv          'privatizacia_predaje-dump.csv'
  after_import :normalize_currency, :empty_columns_to_null
end
