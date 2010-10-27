class Datanest::OtherDotation < ActiveRecord::Base
  extend Datanest::Import

  csv            'ine_dotacie-dump.csv'
  before_create  :convert_financial_attributes, :empty_attributes_to_null
end
