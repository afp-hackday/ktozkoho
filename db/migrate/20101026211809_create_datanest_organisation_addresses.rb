class CreateDatanestOrganisationAddresses < ActiveRecord::Migration
  def self.up
    create_table :datanest_organisation_addresses do |t|
      t.string :address, :limit => 100
      t.references :organisation

      t.timestamps
    end
  end

  def self.down
    drop_table :datanest_organisation_addresses
  end
end
