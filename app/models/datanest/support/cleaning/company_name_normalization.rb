#coding: utf-8
module Datanest
  module Support
    module Cleaning
      module CompanyNameNormalization
        SPOL_SRO_PATTERNS = ['s r.o.', 's.r.o.', 'spol s r.o.', 'spol. s r.o.', 'spol s.r.o.', 'spol. s.r.o.', 'spoločnosť s ručením obmedzeným', 'spol.s r.o.', 'spol.s.r.o.', 'spol. - s.r.o.', 'spol. s r. o.', 'spol.s.r.o', 'spol.s.r.', 'spol. s. r. o.', 'spol.s.r.o', 'spol. s r.o.']
        AS_PATTERNS = ['a.s.', 'a. s.', 'akciová spoločnosť']
        VOS_PATTERNS = ['v.o.s.', 'v.o.s', 'v. o. s.']

        def normalize_company_name
          if respond_to? :company and not company.nil?
            company.gsub!("\302\240", " ")
            squished = company.squish
            company = squished
            { SPOL_SRO_PATTERNS => 's.r.o.', AS_PATTERNS => 'a.s.', VOS_PATTERNS => 'v.o.s.' }.each_pair do |patterns, replacement|
              patterns.each { |pattern| company.gsub!(pattern, replacement) }
            end
          end
        end
      end
    end
  end
end
