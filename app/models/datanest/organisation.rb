class Datanest::Organisation < ActiveRecord::Base
  extend Datanest::FastCSVImport

  csv         'organisations-dump.csv'
end
