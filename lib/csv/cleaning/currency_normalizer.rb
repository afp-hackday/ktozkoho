module CSV
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
