class CreateDatanestOrganisations < ActiveRecord::Migration
  def self.up
    create_table :datanest_organisations, :options => 'ENGINE MyISAM COLLATE utf8_unicode_ci' do |t|
      t.string :name, :limit => 100
      t.integer :ico
      t.string :address, :limit => 200
    end

    sql = <<-ESQL
      CREATE FULLTEXT INDEX idx_ft_name_address ON datanest_organisations(name, address)
    ESQL

    execute sql

    add_index :datanest_organisations, :name
  end

  def self.down
    drop_table :datanest_organisations
  end
end
