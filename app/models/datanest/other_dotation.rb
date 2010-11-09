#coding: utf-8
class Datanest::OtherDotation < ActiveRecord::Base
  include Datanest::Support::Import
  include Datanest::Support::ManuallyMappable

  csv            'ine_dotacie-dump.csv'
  before_create  :convert_financial_attributes, :empty_attributes_to_null,
                 :link_subject
  display_name   'Iné dotácie'

  belongs_to :subject
end
