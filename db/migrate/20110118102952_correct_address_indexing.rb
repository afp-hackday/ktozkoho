class CorrectAddressIndexing < ActiveRecord::Migration
  def self.up
    execute <<-SQL
      DROP INDEX index_datanest_organisation_historical_data_trgm;
      CREATE INDEX index_datanest_organisation_historical_data_trgm ON datanest_organisation_historical_data USING gist(name gist_trgm_ops, strip_address(address) gist_trgm_ops);
    SQL
  end

  def self.down
    execute <<-SQL
      DROP INDEX index_datanest_organisation_historical_data_trgm;
      CREATE INDEX index_datanest_organisation_historical_data_trgm ON datanest_organisation_historical_data USING gist(name gist_trgm_ops, address gist_trgm_ops);
    SQL
  end
end
