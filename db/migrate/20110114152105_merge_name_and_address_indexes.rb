class MergeNameAndAddressIndexes < ActiveRecord::Migration
  def self.up
    execute <<-SQL
      DROP INDEX index_datanest_organisations_in_orsr_on_address_gist_trgm;
      DROP INDEX index_datanest_organisations_in_orsr_on_name_gist_trgm;

      CREATE INDEX index_datanest_organisations_in_orsr_on_name_and_address_trgm
        ON datanest_organisations_in_orsr USING GIST(name gist_trgm_ops, strip_address(address) gist_trgm_ops)
    SQL
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
