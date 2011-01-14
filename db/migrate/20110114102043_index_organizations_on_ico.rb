class IndexOrganizationsOnIco < ActiveRecord::Migration
  def self.up
    add_index :datanest_organisations_in_orsr, :ico, :unique => true
  end

  def self.down
    remove_index :datanest_organisations_in_orsr, :column => :ico
  end
end
