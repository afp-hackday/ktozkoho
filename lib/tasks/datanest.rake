require 'datanest_import'

namespace :datanest do
  desc "Load datanest CSV files into tables"
  task :reload do
    DatanestImport.import_csvs
  end
end
