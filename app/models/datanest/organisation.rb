class Datanest::Organisation < ActiveRecord::Base
  extend CSVImportable

  csv 'organisations-dump.csv'
  csv_columns ['id', 'name', 'ico', 'address']

end
