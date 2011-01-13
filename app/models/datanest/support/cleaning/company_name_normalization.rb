#coding: utf-8
module Datanest
  module Support
    module Cleaning
      module CompanyNameNormalization
        extend ActiveSupport::Concern

        # TODO tu zalezi na poradi - malo by to byt zoradene podla dlzky, inak
        # napriklad s.r.o zhltne s.r.o. a vo vysledku je s.r.o..
        SPOL_SRO_PATTERNS = ['s r.o.', 's.r.o.', 'spol s r.o.', 'spol. s r.o.', 'spol s.r.o.', 'spol. s.r.o.', 'spoločnosť s ručením obmedzeným', 'spol.s r.o.', 'spol.s.r.o.', 'spol. - s.r.o.', 'spol. s r. o.', 'spol.s.r.o', 'spol.s.r.', 'spol. s. r. o.', 'spol.s.r.o', 'spol. s r.o.', 's. r. o.', 's.r.o']
        AS_PATTERNS = ['a.s.', 'a. s.', 'akciová spoločnosť']
        VOS_PATTERNS = ['v.o.s.', 'v.o.s', 'v. o. s.']

        def company_name_column
          :company
        end

        def normalize_company_name
          if self[company_name_column]
            self[company_name_column].gsub!("\302\240", " ")
            squished = self[company_name_column].squish
            self[company_name_column] = squished
            { SPOL_SRO_PATTERNS => 's.r.o.', AS_PATTERNS => 'a.s.', VOS_PATTERNS => 'v.o.s.' }.each_pair do |patterns, replacement|
              patterns.each { |pattern| self[company_name_column].gsub!(pattern, replacement) }
            end
          end
        end

        included do
          def self.set_company_name_column column
            define_method :company_name_column do
              column
            end
          end
        end

      end
    end
  end
end
