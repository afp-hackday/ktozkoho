class CorrectFkNaming < ActiveRecord::Migration
  def self.up
    execute <<-SQL
      DROP INDEX index_datanest_organisation_historical_data_on_org_id;
    SQL
    rename_column :datanest_organisation_historical_data, :datanest_organisation_id, :organisation_id
    add_index :datanest_organisation_historical_data, :organisation_id
  end

  def self.down
    remove_index :datanest_organisation_historical_data, :column => :organisation_id
    rename_column :datanest_organisation_historical_data, :organisation_id, :datanest_organisation_id
    execute <<-SQL
      CREATE INDEX index_datanest_organisation_historical_data_on_org_id ON datanest_organisation_historical_data(datanest_organisation_id);
    SQL
  end
end
