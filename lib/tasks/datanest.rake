namespace :datanest do
  desc "Load datanest CSV files into tables"
  task :reload => :environment do
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
    puts "Loading Organisations.."
    Datanest::Organisation.load_csv_data
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
end
