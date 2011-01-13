#coding: utf-8
module Datanest
  module Support
    module Cleaning
      module PartyNames
        def correct_party_names
          party_corrections = {
            'Smer' => 'SMER',
            'SMER-SD' => 'SMER',
            'SDKÚ-DS' => 'SDKÚ',
            'SDKU' => 'SDKÚ',
            'LS-HZDS' => 'HZDS',
            'NÁDEJ' => 'Nádej'
          }

          unless party_corrections[self[:party]].nil?
            self[:party] = party_corrections[self[:party]]
          end
        end
      end
    end
  end
end
