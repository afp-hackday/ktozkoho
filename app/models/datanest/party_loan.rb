#coding: utf-8
class Datanest::PartyLoan < ActiveRecord::Base
  extend Datanest::Support::Import
  extend Datanest::Support::ManuallyMappable

  csv           'pozicky_stranam-dump.csv'
  before_create :convert_financial_attributes, :correct_party_names, :empty_attributes_to_null,
                :link_subject
  display_name  'Pôžičky stranám'

  belongs_to :subject

  def address
    "#{zip}, #{city}"
  end
end
