namespace :datanest do

  desc "Load datanest CSV files into tables"
  task :cash_flow => :environment do
    puts "Deleting subjects"
    Subject.delete_all
    puts "Loading AgroDotations.."
    Datanest::AgroDotation.load_csv_data
    puts "Loading BuildingDotations.."
    Datanest::BuildingDotation.load_csv_data
    puts "Loading Consolidations.."
    Datanest::Consolidation.load_csv_data
    puts "Loading CultureDotations.."
    Datanest::CultureDotation.load_csv_data
    puts "Loading Eurofonds.."
    Datanest::Eurofond.load_csv_data
    puts "Loading ForgivenTolls.."
    Datanest::ForgivenToll.load_csv_data
    puts "Loading OtherDotations.."
    Datanest::OtherDotation.load_csv_data
    puts "Loading PartyLoans.."
    Datanest::PartyLoan.load_csv_data
    puts "Loading PartySponsors.."
    Datanest::PartySponsor.load_csv_data
    puts "Loading Privatizations.."
    Datanest::Privatization.load_csv_data
    puts "Loading Procurements.."
    Datanest::Procurement.load_csv_data
  end

  desc "Reload organisations table"
  task :organisations => :environment do
    Datanest::Organisation.load_csv_data
  end

  desc "Reloads historical addresses and names for organisations"
  task :historical_data => :environment do
    Wrappers::ORSRWrapper.reload_historical_data
  end

  desc "Reload connections from foaf"
  task :foaf => :environment do
    Wrappers::FoafWrapper.reload_all_connections
  end

  desc "Rebuild advantages table"
  task :advantages => :environment do
    ActiveRecord::Base.connection.execute <<-SQL
      TRUNCATE advantages;
      INSERT INTO advantages
      SELECT subject_id, dotation_amount as profit, year, 'Datanest::AgroDotation' as type FROM datanest_agro_dotations WHERE subject_id IS NOT NULL
      UNION ALL
      SELECT subject_id, assigned_amount as profit, year, 'Datanest::BuildingDotation' as type FROM datanest_building_dotations
      UNION ALL
      SELECT subject_id, amount as profit, date_part('year', updated_at), 'Datanest::Consolidation' as type FROM datanest_consolidations
      UNION ALL
      SELECT subject_id, dissaving as profit, year, 'Datanest::CultureDotation' as type FROM datanest_culture_dotations
      UNION ALL
      SELECT subject_id, grant_amount as profit, year, 'Datanest::Eurofond' as type FROM datanest_eurofonds
      UNION ALL
      SELECT subject_id, amount as profit, year, 'Datanest::ForgivenToll' as type FROM datanest_forgiven_tolls
      UNION ALL
      SELECT subject_id, amount as profit, year, 'Datanest::OtherDotation' as type FROM datanest_other_dotations
      UNION ALL
      SELECT subject_id, price_amount as profit, date_part('year', sold_at), 'Datanest::Privatization' as type FROM datanest_privatizations
      UNION ALL
      SELECT subject_id, price_amount as profit, year, 'Datanest::Procurement' as type FROM datanest_procurements
    SQL
  end
end
