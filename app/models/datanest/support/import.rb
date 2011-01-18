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
        def load_csv_data
          delete_all
          load_csvs
        end

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
          default_mapping
        end

        private

        def load_csvs
          @csvs.each do |csv|
            attributes_update = {}
            ::CSV.foreach("#{Rails.root}/tmp/csv/#{csv.path}", :headers => true, :encoding => 'utf-8') do |row|
              csv.mapping.each { |column, index| attributes_update[column] = row[index] }

              self.new(attributes_update).save
            end
          end
        end
      end
    end
  end
end
