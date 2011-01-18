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
      INSERT INTO advantages(subject_id,profit,year,advantage_type, advantage_id)
      SELECT subject_id, dotation_amount as profit, year, 'Datanest::AgroDotation', id FROM datanest_agro_dotations WHERE subject_id IS NOT NULL
      UNION ALL
      SELECT subject_id, assigned_amount as profit, year, 'Datanest::BuildingDotation', id  FROM datanest_building_dotations WHERE subject_id IS NOT NULL
      UNION ALL
      SELECT subject_id, amount as profit, date_part('year', updated_at), 'Datanest::Consolidation', id  FROM datanest_consolidations WHERE subject_id IS NOT NULL
      UNION ALL
      SELECT subject_id, dissaving as profit, year, 'Datanest::CultureDotation', id  FROM datanest_culture_dotations WHERE subject_id IS NOT NULL
      UNION ALL
      SELECT subject_id, grant_amount as profit, year, 'Datanest::Eurofond', id  FROM datanest_eurofonds WHERE subject_id IS NOT NULL
      UNION ALL
      SELECT subject_id, amount as profit, year, 'Datanest::ForgivenToll', id  FROM datanest_forgiven_tolls WHERE subject_id IS NOT NULL
      UNION ALL
      SELECT subject_id, amount as profit, year, 'Datanest::OtherDotation', id  FROM datanest_other_dotations WHERE subject_id IS NOT NULL
      UNION ALL
      SELECT subject_id, price_amount as profit, date_part('year', sold_at), 'Datanest::Privatization', id  FROM datanest_privatizations WHERE subject_id IS NOT NULL
      UNION ALL
      SELECT subject_id, price_amount as profit, year, 'Datanest::Procurement', id  FROM datanest_procurements WHERE subject_id IS NOT NULL
    SQL
  end

  desc "Rebuild investments table"
  task :investments => :environment do
    ActiveRecord::Base.connection.execute <<-SQL
      TRUNCATE investments;
      INSERT INTO investments(subject_id,amount,year,investment_type, investment_id, party_id)
      SELECT subject_id, amount, year, 'Datanest::PartyLoan', id, party_id FROM datanest_party_loans WHERE subject_id IS NOT NULL
      UNION ALL
      SELECT subject_id, amount, year, 'Datanest::PartySponsor', id, party_id FROM datanest_party_sponsors WHERE subject_id IS NOT NULL
    SQL
  end
end
