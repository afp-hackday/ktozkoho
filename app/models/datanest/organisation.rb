class Datanest::Organisation < ActiveRecord::Base
  extend CSV::Import

  csv         'organisations-dump.csv'
  csv_columns ['id', 'name', 'ico', 'address']
end
