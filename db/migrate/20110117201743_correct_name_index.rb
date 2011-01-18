class CorrectNameIndex < ActiveRecord::Migration
  def self.up
    execute <<-SQL
      CREATE INDEX index_datanest_organisations_on_lower_name ON datanest_organisations(LOWER(name));
    SQL
  end

  def self.down
    execute <<-SQL
      DROP INDEX index_datanest_organisations_on_lower_name;
    SQL
  end
end
