class Datanest::Consolidation < ActiveRecord::Base
  extend Datanest::Import

  csv           'konsolidacna-dump.csv'
  before_create :convert_financial_attributes

  def address
    "#{psc} #{city}"
  end
end
