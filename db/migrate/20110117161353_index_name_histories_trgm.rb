class IndexNameHistoriesTrgm < ActiveRecord::Migration
  def self.up
    execute <<-SQL
      CREATE INDEX index_datanest_name_histories_on_name_trgm ON datanest_organisation_name_histories USING gist(name gist_trgm_ops);
    SQL
  end

  def self.down
    execute <<-SQL
      DROP INDEX index_datanest_name_histories_on_name_trgm;
    SQL
  end
end
