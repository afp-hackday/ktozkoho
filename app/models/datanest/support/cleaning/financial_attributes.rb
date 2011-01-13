module Datanest
  module Support
    module Cleaning
      module FinancialAttributes
        extend ActiveSupport::Concern

        def currency_columns
          attribute_names.grep(/amount$/)
        end

        included do
          def self.additional_currency_columns *currency_columns
            define_method :currency_columns do
              attribute_names.grep(/amount$/) + currency_columns
            end
          end
        end

        def convert_financial_attributes
          puts "Convering: #{currency_columns}"
          exchange = {
            'Sk' => 30.126,
            'SKK' => 30.126,
            'Skk' => 30.126,
            'ECU' => 1,
            'GBP' => 0.878,
            'CZK' => 24.515,
            'USD' => 1.409,
            'Eur' => 1
          }

          currency_columns.each do |column|
            next if self[:currency] == 'EUR' or self[:currency].nil? or self[:currency].empty?

            unless exchange[self[:currency]].nil?
              self[column] = self[column] / exchange[self[:currency]] unless self[column].nil?
              self[:currency] = 'EUR'
            else
              puts "Unknown currency #{self[:currency]}"
            end
          end
        end
      end
    end
  end
end
