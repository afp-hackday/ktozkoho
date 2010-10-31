class AddManualMappingAttributes < ActiveRecord::Migration
  def self.up
    add_column :datanest_party_sponsors, :locked_at, :timestamp
  end

  def self.down
    remove_column :datanest_party_sponsors, :locked_at
  end
end
