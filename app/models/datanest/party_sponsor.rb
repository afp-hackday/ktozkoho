class Datanest::PartySponsor < ActiveRecord::Base
  extend CSVImportable

  csv         'sponzori_stran-dump.csv'
  csv_columns ['id', 'name', 'surname', 'title', 'company', 'ico',
               'amount', 'currency', 'address', '@dummy', '@dummy',
               'party', 'year', '@dummy', '@dummy']

  after_import :normalize_currency, :normalize_party_names

end
