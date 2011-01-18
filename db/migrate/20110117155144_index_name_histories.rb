class IndexNameHistories < ActiveRecord::Migration
  def self.up
    execute <<-SQL
      CREATE INDEX index_datanest_name_histories_on_lower_name ON datanest_organisation_name_histories(LOWER(name) varchar_pattern_ops);
    SQL
  end

  def self.down
    execute <<-SQL
      DROP INDEX index_datanest_name_histories_on_lower_name;
    SQL
  end
end
