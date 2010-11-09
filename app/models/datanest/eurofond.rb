#coding: utf-8
class Datanest::Eurofond < ActiveRecord::Base
  extend Datanest::Support::Import
  extend Datanest::Support::ManuallyMappable

  csv                         'eurofondy-dump.csv'
  additional_currency_columns :budget
  before_create               :convert_financial_attributes, :empty_attributes_to_null,
                              :link_subject
  display_name                'Eurofondy'

  belongs_to :subject
end
