class RemoveOrganisationPartitioning < ActiveRecord::Migration
  def self.up
    execute <<-SQL
      DROP TRIGGER insert_organisations_trigger ON datanest_organisations;
      DROP FUNCTION organisations_insert_trigger();
      DROP TABLE datanest_organisations_in_orsr;
      DROP TABLE datanest_organisations_not_in_orsr;
    SQL
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
