# coding: utf-8

module CSV
  module Import
    def csv name
      @csv_name = name
    end

    def csv_columns columns
      @csv_columns = columns
    end

    def load_csv_data
      delete_all

      csv = "#{Rails.root}/tmp/csv/#{@csv_name}"

      fast_import(csv, :fields_terminated_by => ',' ,
                  :fields_optionally_enclosed_by => '"',
                  :columns => @csv_columns,
                  :ignore_lines => 1)

      invoke_after_import_callbacks
    end

    def after_import *methods
      @after_import_callbacks = methods
    end

    def self.extended(base)
      base.extend Cleaning::CurrencyNormalizer
      base.extend Cleaning::PartyNameNormalizer
      base.extend Cleaning::ICONuller
      base.extend Cleaning::EmptyColumnsToNULL
      base.extend Cleaning::ICOMapper
    end

    private

    def invoke_after_import_callbacks
      @after_import_callbacks ||= []
      @after_import_callbacks.each { |callback| send callback }
    end

    module Cleaning
      module CurrencyNormalizer

        def currency_columns currency_columns
          @currency_columns = currency_columns
        end

        def normalize_currency
          @currency_columns ||= [:amount]
          currency_column_update = @currency_columns.map { |c| "#{c.to_s} = #{c.to_s}/30.126" }.join(',')

          update_all("currency = 'EUR', #{currency_column_update}", :currency => ['Sk', 'SKK', 'Skk'])
        end
      end

      module PartyNameNormalizer
        def normalize_party_names
          party_variants = {
            'SMER' => ['Smer', 'SMER-SD'],
            'SDKÚ' => ['SDKÚ-DS']
          }

          party_variants.each do |party, variants|
            update_all({:party => party}, :party => variants)
          end
        end
      end

      module ICONuller
        def null_icos
          update_all("ico = NULL", :ico => 0)
        end
      end

      module EmptyColumnsToNULL
        def empty_columns_to_null
          column_names.each do |column_name|
            update_all("#{column_name} = NULL", ["#{column_name} = ?", ''])
          end
        end
      end
    end
  end
end
