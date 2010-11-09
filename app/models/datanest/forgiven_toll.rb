#coding: utf-8
class Datanest::ForgivenToll < ActiveRecord::Base
  extend Datanest::Import
  extend Datanest::ManuallyMappable

  csv            'odpustene_clo-dump.csv'
  before_create  :convert_financial_attributes, :empty_attributes_to_null,
                 :link_subject
  display_name   'Odpustené clo'

  belongs_to :subject
end
