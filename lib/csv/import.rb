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
      base.extend CSV::Cleaning::CurrencyNormalizer
      base.extend CSV::Cleaning::PartyNameNormalizer
      base.extend CSV::Cleaning::ICONuller
      base.extend CSV::Cleaning::EmptyColumnsToNULL
      base.extend CSV::Cleaning::ICOMapper
    end

    private

    def invoke_after_import_callbacks
      @after_import_callbacks ||= []
      @after_import_callbacks.each { |callback| send callback }
    end
  end
end
