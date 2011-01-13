#coding: utf-8
module Datanest
  module Support
    module Cleaning
      module CompanyNameNormalization
        extend ActiveSupport::Concern

        SPOL_SRO_PATTERNS = ['s r.o.', 'spol s r.o.', 'spol. s r.o.', 'spol s.r.o.', 'spol. s.r.o.', 'spoločnosť s ručením obmedzeným', 'spol.s r.o.', 'spol.s.r.o.', 'spol. - s.r.o.', 'spol. s r. o.', 'spol.s.r.o', 'spol.s.r.', 'spol. s. r. o.', 'spol. s r.o.', 's. r. o.', 's.r.o'].sort{|a,b| a.length <=> b.length}.reverse.unshift('s.r.o.').freeze
        AS_PATTERNS = ['a.s.', 'a. s.', 'akciová spoločnosť'].freeze
        VOS_PATTERNS = ['v.o.s.', 'v.o.s', 'v. o. s.'].freeze

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
