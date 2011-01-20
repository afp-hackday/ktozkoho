require 'csv'

module Datanest
  module Support
    module Import
      extend ActiveSupport::Concern

      included do
        include Datanest::Support::Cleaning::FinancialAttributes
        include Datanest::Support::Cleaning::PartyMapper
        include Datanest::Support::Cleaning::SubjectMapper
        include Datanest::Support::Cleaning::EmptyAttributesToNull
        include Datanest::Support::Cleaning::CompanyNameNormalization
        include Datanest::Support::Cleaning::ICONormalization
      end

      module ClassMethods
        @csvs = []
        CSV = Struct.new(:path, :mapping)

        def csv path, column_mapping = nil
          @csvs ||= []
          column_mapping = default_mapping if column_mapping.nil?
          @csvs << CSV.new(path, column_mapping)
        end

        def default_mapping
          default_mapping = {}
          column_names.each_with_index { |column, index| default_mapping[column] = index }
          default_mapping['datanest_id'] = 0;
          default_mapping
        end

        def load_csv_data
          @csvs.each do |csv|
            attributes = {}
            ::CSV.foreach("#{Rails.root}/tmp/csv/#{csv.path}", :headers => true, :encoding => 'utf-8') do |row|
              csv.mapping.each { |column, index| attributes[column] = row[index] }

              record = find_by_datanest_id(attributes['datanest_id'])
              if record
                record.update_attributes(attributes)
              else
                create(attributes)
              end
            end
          end
        end
      end
    end
  end
end
