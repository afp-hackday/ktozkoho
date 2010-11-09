#coding: utf-8
class Datanest::Consolidation < ActiveRecord::Base
  extend Datanest::Import
  extend Datanest::ManuallyMappable

  csv           'konsolidacna-dump.csv'
  before_create :convert_financial_attributes, :empty_attributes_to_null,
                :link_subject
  display_name  'Slovenská konsolidačná'

  belongs_to :subject

  def address
    "#{psc} #{city}"
  end
end
