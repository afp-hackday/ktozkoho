class Datanest::PartySponsor < ActiveRecord::Base
  extend CSV::Import

  csv         'sponzori_stran-dump.csv'
  csv_columns ['id', 'name', 'surname', 'title', 'company', 'ico',
               'amount', 'currency', 'address', '@dummy', '@dummy',
               'party', 'year']

  after_import :normalize_currency, :normalize_party_names,
               :null_icos, :empty_columns_to_null, :map_icos

  ico_map_condition 'company IS NOT NULL AND ico IS NULL'

end
