class Datanest::Consolidation < ActiveRecord::Base
  extend CSV::Import

  csv         'konsolidacna-dump.csv'
  after_import :normalize_currency, :null_icos, :empty_columns_to_null

  def address
    "#{psc} #{city}"
  end
end
