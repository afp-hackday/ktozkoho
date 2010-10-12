module CSVImportable
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

  def after_import method
    @after_import_callbacks ||= []
    @after_import_callbacks << method
  end

  def self.extended(base)
    base.extend Cleaning::CurrencyNormalizer
  end

  private

  def invoke_after_import_callbacks
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
  end
end
