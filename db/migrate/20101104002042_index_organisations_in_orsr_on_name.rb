class IndexOrganisationsInOrsrOnName < ActiveRecord::Migration
  def self.up
    execute <<-SQL
      CREATE INDEX index_datanest_organisations_in_orsr_on_lower_name
        ON datanest_organisations_in_orsr (lower(name))
    SQL
  end

  def self.down
    execute <<-SQL
      DROP INDEX index_datanest_organisations_in_orsr_on_lower_name
    SQL
  end
end
