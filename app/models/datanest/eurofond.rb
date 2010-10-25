class Datanest::Eurofond < ActiveRecord::Base
  extend Datanest::Import

  csv                         'eurofondy-dump.csv'
  additional_currency_columns :budget
  before_create               :convert_financial_attributes
end
