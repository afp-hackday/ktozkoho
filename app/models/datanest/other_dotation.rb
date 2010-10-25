class Datanest::OtherDotation < ActiveRecord::Base
  extend Datanest::Import

  csv            'ine_dotacie-dump.csv'
  before_create  :convert_financial_attributes
end
