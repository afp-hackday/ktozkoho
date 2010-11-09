class AddMappingAttributes < ActiveRecord::Migration
  def self.up
    [:datanest_agro_dotations,
     :datanest_building_dotations,
     :datanest_consolidations,
     :datanest_culture_dotations,
     :datanest_eurofonds,
     :datanest_forgiven_tolls,
     :datanest_other_dotations,
     :datanest_party_loans,
     :datanest_party_sponsors,
     :datanest_privatizations,
     :datanest_procurements].each do |table|

      add_column table, :mapping_strategy, :string, :limit => 20
      add_column table, :subject_id, :integer
    end
  end

  def self.down

    [:datanest_agro_dotations,
     :datanest_building_dotations,
     :datanest_consolidations,
     :datanest_culture_dotations,
     :datanest_eurofonds,
     :datanest_forgiven_tolls,
     :datanest_other_dotations,
     :datanest_party_loans,
     :datanest_party_sponsors,
     :datanest_privatizations,
     :datanest_procurements].each do |table|

      remove_column table, :mapping_strategy
      remove_column table, :subject_id
    end
  end
end
