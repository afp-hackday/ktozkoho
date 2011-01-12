#coding: utf-8
class Datanest::AgroDotation < ActiveRecord::Base
  include Datanest::Base
  include Datanest::Support::Import
  include Datanest::Support::ManuallyMappable

  csv           'polnodotacie-dump.csv'
  before_create :convert_financial_attributes, :empty_attributes_to_null,
                :link_subject
  display_name  'Agro dotácie'

  belongs_to :subject
end
