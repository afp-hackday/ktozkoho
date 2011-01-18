class TidyUpAdvantagesABit < ActiveRecord::Migration
  def self.up
    rename_column :advantages, :type, :advantage_type
    add_column :advantages, :advantage_id, :integer
  end

  def self.down
    remove_column :advantages, :advantage_id
    rename_column :advantages, :advantage_type, :type
  end
end
