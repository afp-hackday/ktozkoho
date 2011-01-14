class OrganisationsIndexLike < ActiveRecord::Migration
  def self.up
    execute <<-SQL
      DROP INDEX index_datanest_organisations_in_orsr_on_lower_name;
      CREATE INDEX index_datanest_organisations_in_orsr_on_lower_name 
        ON datanest_organisations_in_orsr(LOWER(name) varchar_pattern_ops);
    SQL
  end

  def self.down
    execute <<-SQL
      DROP INDEX index_datanest_organisations_in_orsr_on_lower_name;
      CREATE INDEX index_datanest_organisations_in_orsr_on_lower_name 
        ON datanest_organisations_in_orsr(LOWER(name));
    SQL
  end
end
