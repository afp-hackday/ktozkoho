require 'csv'

module Datanest
  module Import
    include CSVImportBase

    def load_csv_data
      delete_all

      CSV.foreach("#{Rails.root}/tmp/csv/#{@csv_name}", :headers => true, :encoding => 'utf-8') do |row|
        attributes_update = {}
        column_names.each_with_index do |column, idx|
          attributes_update[column] = row[idx]
        end

        self.new(attributes_update).save
      end
    end

    def self.extended(base)
      base.extend Datanest::Cleaning::FinancialAttributes::ClassMethods
      base.send :include, Datanest::Cleaning::FinancialAttributes::InstanceMethods
      base.send :include, Datanest::Cleaning::PartyNames
      base.send :include, Datanest::Cleaning::OrganisationMapper
      base.send :include, Datanest::Cleaning::EmptyAttributesToNull
    end
  end
end
