#coding: utf-8
module Datanest
  module Support
    module Cleaning
      module PartyMapper
        def map_party
          party_corrections = {
              'Smer'  => 'SMER-SD',
              'SMER'  => 'SMER-SD',
              'SDKÚ'  => 'SDKÚ-DS',
              'SDKU'  => 'SDKÚ-DS',
              'HZDS'  => 'LS-HZDS',
              'NÁDEJ' => 'EDS',
              'Nádej' => 'EDS'
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
