class AddDatanestIdToOrganisations < ActiveRecord::Migration
  def self.up
    add_column :datanest_organisations, :datanest_id, :integer, :null => false
    add_index  :datanest_organisations, :datanest_id, :unique => true
  end

  def self.down
    remove_index :datanest_organisations, :column => :datanest_id
    remove_column :datanest_organisations, :datanest_id
  end
end
