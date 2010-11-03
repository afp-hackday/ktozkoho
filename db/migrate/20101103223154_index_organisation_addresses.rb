class IndexOrganisationAddresses < ActiveRecord::Migration
  def self.up
    add_index :datanest_organisation_addresses, :organisation_id
    execute <<-SQL
      CREATE INDEX index_datanest_organisation_addresses_on_address_gist_trgm
        ON datanest_organisation_addresses USING GIST(address gist_trgm_ops)
    SQL
  end

  def self.down
    remove_index :datanest_organisation_addresses, :name => :index_datanest_organisation_addresses_on_address_gist_trgm
    remove_index :datanest_organisation_addresses, :column => :organisation_id
  end
end
