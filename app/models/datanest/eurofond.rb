class Datanest::Eurofond < ActiveRecord::Base
  extend CSV::Import

  csv                         'eurofondy-dump.csv'
  additional_currency_columns :budget
  after_import                :normalize_currency, :null_icos, :empty_columns_to_null
end
