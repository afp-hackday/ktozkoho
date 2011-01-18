class IndexOrganisationsOnIco < ActiveRecord::Migration
  def self.up
    add_index :datanest_organisations, :ico
  end

  def self.down
    remove_index :datanest_organisations, :column => :ico
  end
end
