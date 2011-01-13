class ConnectPartiesWithRelations < ActiveRecord::Migration
  def self.up
    add_column :datanest_party_loans, :party_id, :integer
    add_column :datanest_party_sponsors, :party_id, :integer
  end

  def self.down
    remove_column :datanest_party_sponsors, :party_id
    remove_column :datanest_party_loans, :party_id
  end
end
