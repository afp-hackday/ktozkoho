class CreateConnections < ActiveRecord::Migration
  def self.up
    create_table :connections do |t|
      t.integer :subject_id, :null => false
      t.integer :connected_subject_id, :null => false

      t.timestamps
    end

    add_index :connections, [:subject_id, :connected_subject_id]
  end

  def self.down
    drop_table :connections
  end
end
