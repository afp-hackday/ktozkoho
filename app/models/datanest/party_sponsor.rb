class Datanest::PartySponsor < ActiveRecord::Base
  extend CSV::Import

  csv          'sponzori_stran-dump.csv'
  after_import :normalize_currency, :normalize_party_names,
               :null_icos, :empty_columns_to_null

end
