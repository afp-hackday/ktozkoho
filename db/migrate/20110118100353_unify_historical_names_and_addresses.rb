class UnifyHistoricalNamesAndAddresses < ActiveRecord::Migration
  def self.up
    drop_table :datanest_organisation_name_histories
    drop_table :datanest_organisation_addresses

    create_table :datanest_organisation_historical_data do |t|
      t.string :name, :limit => 200
      t.string :address, :limit => 200
      t.references :datanest_organisation
      t.timestamps
    end

    execute <<-SQL
      DROP INDEX index_datanest_organisations_on_lower_name;
      CREATE INDEX index_datanest_organisation_historical_data_on_lower_name ON datanest_organisation_historical_data(LOWER(name));
      CREATE INDEX index_datanest_organisation_historical_data_on_lower_name_ops ON datanest_organisation_historical_data(LOWER(name) varchar_pattern_ops);
      CREATE INDEX index_datanest_organisation_historical_data_trgm ON datanest_organisation_historical_data USING gist(name gist_trgm_ops, address gist_trgm_ops);
      CREATE INDEX index_datanest_organisation_historical_data_on_org_id ON datanest_organisation_historical_data(datanest_organisation_id);
    SQL
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
