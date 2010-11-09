#coding: utf-8
class Datanest::OtherDotation < ActiveRecord::Base
  extend Datanest::Import
  extend Datanest::ManuallyMappable

  csv            'ine_dotacie-dump.csv'
  before_create  :convert_financial_attributes, :empty_attributes_to_null,
                 :link_subject
  display_name   'Iné dotácie'

  belongs_to :subject
end
