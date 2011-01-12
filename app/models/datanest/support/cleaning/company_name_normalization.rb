#coding: utf-8
module Datanest
  module Support
    module Cleaning
      module CompanyNameNormalization
        extend ActiveSupport::Concern

        class << self
          attr_accessor :company_name_column
        end

        SPOL_SRO_PATTERNS = ['s r.o.', 's.r.o.', 'spol s r.o.', 'spol. s r.o.', 'spol s.r.o.', 'spol. s.r.o.', 'spoločnosť s ručením obmedzeným', 'spol.s r.o.', 'spol.s.r.o.', 'spol. - s.r.o.', 'spol. s r. o.', 'spol.s.r.o', 'spol.s.r.', 'spol. s. r. o.', 'spol.s.r.o', 'spol. s r.o.']
        AS_PATTERNS = ['a.s.', 'a. s.', 'akciová spoločnosť']
        VOS_PATTERNS = ['v.o.s.', 'v.o.s', 'v. o. s.']

        def normalize_company_name
          CompanyNameNormalization.company_name_column ||= :company

          company = CompanyNameNormalization.company_name_column

          if self[company]
            self[company].gsub!("\302\240", " ")
            squished = self[company].squish
            self[company] = squished
            { SPOL_SRO_PATTERNS => 's.r.o.', AS_PATTERNS => 'a.s.', VOS_PATTERNS => 'v.o.s.' }.each_pair do |patterns, replacement|
              patterns.each { |pattern| self[company].gsub!(pattern, replacement) }
            end
          end
        end

        module ClassMethods
          def set_company_name_column column
            CompanyNameNormalization.company_name_column = column
          end
        end
      end
    end
  end
end
