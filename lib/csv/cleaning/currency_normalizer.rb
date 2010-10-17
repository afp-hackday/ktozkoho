module CSV
  module Cleaning
    module CurrencyNormalizer

      def additional_currency_columns *currency_columns
        @additional_currency_columns = currency_columns
      end

      def normalize_currency
        currency_columns = column_names.grep(/amount$/)
        @additional_currency_columns ||= []
        currency_columns += @additional_currency_columns

        exchange = {
          ['Sk', 'SKK', 'Skk'] => 30.126,
          ['ECU'] => 1,
          ['GBP'] => 0.878,
          ['CZK'] => 24.515,
          ['USD'] => 1.409
        }

        exchange.each do |currencies, rate|
          currency_column_update = currency_columns.map { |c| "#{c.to_s} = #{c.to_s}/#{rate}" }.join(',')
          update_all("currency = 'EUR', #{currency_column_update}", :currency => currencies)
        end
      end
    end
  end
end
