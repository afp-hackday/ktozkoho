class CreateDatanestOrganisations < ActiveRecord::Migration
  def self.up
    create_table :datanest_organisations do |t|
      t.string :name, :limit => 100
      t.integer :ico
      t.string :address, :limit => 200
    end
  end

  def self.down
    drop_table :datanest_organisations
  end
end
