class Datanest::Organisation < ActiveRecord::Base
  extend Datanest::FastCSVImport

  csv         'organisations-dump.csv'

  has_many :addresses, :class_name => 'Datanest::OrganisationAddress'
  has_many :name_histories, :class_name => 'Datanest::OrganisationNameHistory'
end
