class Datanest::PartyLoan < ActiveRecord::Base
  extend CSV::Import

  csv         'pozicky_stranam-dump.csv'
  after_import :normalize_currency, :null_icos, :empty_columns_to_null,
               :normalize_party_names
end
