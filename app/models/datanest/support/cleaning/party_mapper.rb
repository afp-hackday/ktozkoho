#coding: utf-8
module Datanest
  module Support
    module Cleaning
      module PartyMapper
        def map_party
          party_corrections = {
            'Smer' => 'SMER',
            'SMER-SD' => 'SMER',
            'SDKÚ-DS' => 'SDKÚ',
            'SDKU' => 'SDKÚ',
            'LS-HZDS' => 'HZDS',
            'NÁDEJ' => 'Nádej'
          }

          unless party_corrections[self[:party_name]].nil?
            self[:party_name] = party_corrections[self[:party_name]]
          end

          self.party = Party.find_by_acronym(self[:party_name])
        end
      end
    end
  end
end
