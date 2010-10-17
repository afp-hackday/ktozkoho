#coding: utf-8
module CSV
  module Cleaning
    module PartyNameNormalizer
      def normalize_party_names
        party_variants = {
          'SMER' => ['Smer', 'SMER-SD'],
          'SDKÚ' => ['SDKÚ-DS', 'SDKU'],
          'HZDS' => ['LS-HZDS']
        }

        party_variants.each do |party, variants|
          update_all({:party => party}, :party => variants)
        end
      end
    end
  end
end
