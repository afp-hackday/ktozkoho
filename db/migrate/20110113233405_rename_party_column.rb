class RenamePartyColumn < ActiveRecord::Migration
  def self.up
    rename_column :datanest_party_sponsors, :party, :party_name
    rename_column :datanest_party_loans, :party, :party_name
  end

  def self.down
    rename_column :datanest_party_loans, :party_name, :party
    rename_column :datanest_party_sponsors, :party_name, :party
  end
end
